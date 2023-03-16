//
//  CameraViewController.swift
//  spoof-sense-ios
//
//  Created by iMac on 09/02/23.
//

import UIKit
import AVKit

public class CameraViewController: UIViewController {
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var btnCapture: UIButton!
    @IBOutlet weak var viewMainCamera: UIView!
    @IBOutlet weak var viewSubCamera: UIView!
    @IBOutlet weak var activityIndicatorResult: UIActivityIndicatorView!
    
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    var resultCameraVM = ResultCameraViewModel()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.hideLoader()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupCameraView()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession.stopRunning()
        captureSession = nil
        stillImageOutput = nil
        videoPreviewLayer = nil
    }
    
    func showLoader() {
        activityIndicatorResult.isHidden = false
        activityIndicatorResult.startAnimating()
    }
    
    func hideLoader() {
        activityIndicatorResult.isHidden = true
        activityIndicatorResult.stopAnimating()
    }
}

private extension CameraViewController {
    func setupUI() {
        setCustomUI()
    }
    
    func setCustomUI() {
        viewMainCamera.clipsToBounds = true
        viewMainCamera.layer.borderWidth = 2
        viewMainCamera.layer.borderColor = UIColor.white.cgColor
        viewSubCamera.layer.cornerRadius = viewSubCamera.bounds.height / 2
        viewMainCamera.layer.cornerRadius = viewMainCamera.bounds.height / 2
    }
    
    func setupCameraView() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        guard let cam = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
            print("Unable to access front camera!")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: cam)
            stillImageOutput = AVCapturePhotoOutput()
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
    }
    
    func setupLivePreview() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = .resizeAspectFill//.resizeAspect
        videoPreviewLayer.connection?.videoOrientation = .portrait
        previewView.layer.addSublayer(videoPreviewLayer)
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
            DispatchQueue.main.async {
                self.videoPreviewLayer.frame = self.previewView.bounds
            }
        }
    }
    
    func goToResultView() {
        if SpoofSense.showResultScreen {
            let podBundle = Bundle(for: ResultViewController.self)
            let storyBoard = UIStoryboard.init(name: "SpoofSense", bundle: podBundle)
            let vc = storyBoard.instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController
            vc?.resultCameraVM = self.resultCameraVM
            
            guard self.navigationController == nil else {
                self.navigationController?.pushViewController(vc!, animated: SpoofSense.isNaigationControllerAnimated)
                return
            }
            
            self.dismiss(animated: SpoofSense.isNaigationControllerAnimated) {
                SpoofSense.navigation?.pushViewController(vc!, animated: SpoofSense.isNaigationControllerAnimated)
            }
        } else {
            self.callImageResultApi()
        }
    }
    
    func callImageResultApi() {
        self.showLoader()
        resultCameraVM.postURLSessionGetData { stringValue in
            self.hideLoader()
            SpoofSense.resultCallBack?(self.resultCameraVM.jsonObject)
        } failure: { err in
            self.hideLoader()
            SpoofSense.resultCallBack?(self.resultCameraVM.jsonObject)
        }
    }
}

private extension CameraViewController {
    @IBAction func didTakePhoto(_ sender: UIButton) {
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        stillImageOutput.capturePhoto(with: settings, delegate: self)
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(),
                let originalImg = UIImage(data: imageData) else {
            return
        }
        
        let imgWidth = 1008
        let requiredImgHeight = imgWidth + Int(imgWidth / 3)
        
        let resizedImgData = originalImg.resizeImage(targetSize: CGSize(width: imgWidth, height: requiredImgHeight), quality: .medium)
        let strBase64 = resizedImgData.base64EncodedString(options: .lineLength64Characters)
        self.resultCameraVM.base64ImageData = strBase64
        self.goToResultView()
    }
}

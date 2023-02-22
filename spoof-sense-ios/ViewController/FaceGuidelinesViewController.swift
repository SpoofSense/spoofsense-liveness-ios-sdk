//
//  FaceGuidelinesViewController.swift
//  spoof-sense-ios
//
//  Created by iMac on 09/02/23.
//

import UIKit

public class FaceGuidelinesViewController: UIViewController {
    
    @IBOutlet weak var btnCheckLiveness: UIButton!
    @IBOutlet weak var imageFaceTrueDetect: UIImageView!
    @IBOutlet weak var imageVuewNoFaceDetect: UIImageView!
    @IBOutlet weak var imageViewMultiFace: UIImageView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

private extension FaceGuidelinesViewController {
    func setupUI() {
        btnCheckLiveness.clipsToBounds = true
        btnCheckLiveness.layer.cornerRadius = 4
        let podBundle = Bundle(for: FaceGuidelinesViewController.self)
        let image1 = UIImage(named: "ic_face_right", in: podBundle, compatibleWith: nil)
        let image2 = UIImage(named: "ic_wrong_face", in: podBundle, compatibleWith: nil)
        let image3 = UIImage(named: "ic_multi_face", in: podBundle, compatibleWith: nil)
        imageFaceTrueDetect.image = image1
        imageVuewNoFaceDetect.image = image2
        imageViewMultiFace.image = image3
        self.setCustomUI()
    }
    
    func setCustomUI() {
        btnCheckLiveness.setTitle(SpoofSense.guidelinesButtonTextTitle, for: .normal)
        btnCheckLiveness.setTitleColor(SpoofSense.buttonTitleColor, for: .normal)
        btnCheckLiveness.backgroundColor = SpoofSense.buttonBackgroundColor
    }
}

private extension FaceGuidelinesViewController {
    @IBAction func onBtnCheckLiveness(_ sender: UIButton) {
        if self.navigationController == nil {
            self.dismiss(animated: SpoofSense.isNaigationControllerAnimated) {
                let podBundle = Bundle(for: CameraViewController.self)
                let storyBoard = UIStoryboard.init(name: "SpoofSense", bundle: podBundle)
                let vc = storyBoard.instantiateViewController(withIdentifier: "CameraViewController") as? CameraViewController
                SpoofSense.navigation?.pushViewController(vc!, animated: SpoofSense.isNaigationControllerAnimated)
            }
        } else {
            let podBundle = Bundle(for: CameraViewController.self)
            let storyBoard = UIStoryboard.init(name: "SpoofSense", bundle: podBundle)
            let vc = storyBoard.instantiateViewController(withIdentifier: "CameraViewController") as? CameraViewController
            self.navigationController?.pushViewController(vc!, animated: SpoofSense.isNaigationControllerAnimated)
        }
    }
}

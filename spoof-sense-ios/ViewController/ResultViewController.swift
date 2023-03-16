//
//  ResultViewController.swift
//  spoof-sense-ios
//
//  Created by iMac on 09/02/23.
//

import UIKit

public class ResultViewController: UIViewController {

    var resultCameraVM = ResultCameraViewModel()
    var isResultFaild: Bool = false
    @IBOutlet weak var viewShowMessgae: UIView!
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var activityIndicatorResult: UIActivityIndicatorView!
    @IBOutlet weak var btnClose: UIButton!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
}

private extension ResultViewController {
    func setupUI() {
        self.hideLoader()
        self.viewShowMessgae.isHidden = true
        self.callImageResultApi()
        btnHome.clipsToBounds = true
        btnHome.layer.cornerRadius = 4
        btnHome.setTitleColor(SpoofSense.buttonTitleColor, for: .normal)
        btnHome.backgroundColor = SpoofSense.buttonBackgroundColor
        let podBundle = Bundle(for: ResultViewController.self)
        let image = UIImage(named: "ic_close", in: podBundle, compatibleWith: nil)
        btnClose.setImage(image, for: .normal)
    }
    
    func showLoader() {
        activityIndicatorResult.isHidden = false
        activityIndicatorResult.startAnimating()
    }
    
    func hideLoader() {
        activityIndicatorResult.isHidden = true
        activityIndicatorResult.stopAnimating()
    }
    
    func showResultText(_ isSucess: Bool, message: String) {
        self.viewShowMessgae.isHidden = false
        lblText.text = message
        let podBundle = Bundle(for: ResultViewController.self)
        if isSucess {
            isResultFaild = false
            let image = UIImage(named: "ic_sucess", in: podBundle, compatibleWith: nil)
            imageViewLogo.image = image
            btnHome.setTitle("Home", for: .normal)
        } else {
            isResultFaild = true
            let image = UIImage(named: "ic_faild", in: podBundle, compatibleWith: nil)
            imageViewLogo.image = image
            btnHome.setTitle("Try again", for: .normal)
        }
    }
}

private extension ResultViewController {
    @IBAction func onBtnBack(_ sender: UIButton) {
        print("jsonObject: ", resultCameraVM.jsonObject)
        SpoofSense.resultCallBack?(resultCameraVM.jsonObject)
    }
    
    @IBAction func onBtnGoToHome(_ sender: UIButton) {
        if isResultFaild {
            self.navigationController?.popViewController(animated: true)
        } else {
            print("jsonObject: ", resultCameraVM.jsonObject)
            SpoofSense.resultCallBack?(resultCameraVM.jsonObject)
        }
    }
}

private extension ResultViewController {
    func callImageResultApi() {
        self.showLoader()
        resultCameraVM.postURLSessionGetData { stringValue in
            self.hideLoader()
            self.showResultText(true, message: stringValue)
        } failure: { err in
            self.hideLoader()
            self.showResultText(false, message: err?.localizedDescription ?? "")
        }
    }
}

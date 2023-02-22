//
//  SplaceViewController.swift
//  spoof-sense-ios
//
//  Created by iMac on 09/02/23.
//

import UIKit

public class SplaceViewController: UIViewController {
    
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var lblVersionNumber: UILabel!
    @IBOutlet weak var btnCheckLiveness: UIButton!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
}

private extension SplaceViewController {
    func setupUI() {
        btnCheckLiveness.clipsToBounds = true
        btnCheckLiveness.layer.cornerRadius = 4
        let podBundle = Bundle(for: SplaceViewController.self)
        let image1 = UIImage(named: "ic_splace_logo", in: podBundle, compatibleWith: nil)
        imageViewLogo.image = image1
        self.setCustomUI()
    }
    
    func setCustomUI() {
        imageViewLogo.image = SpoofSense.appLogo
        lblFirstName.text = SpoofSense.appFirstName
        lblLastName.text = SpoofSense.appLastName
        lblVersionNumber.text = SpoofSense.versionNumberString
        lblFirstName.textColor = SpoofSense.appFirstNameColor
        lblLastName.textColor = SpoofSense.appLastNameColor
        lblVersionNumber.textColor = SpoofSense.versionNumberColor
        btnCheckLiveness.setTitle(SpoofSense.splashButtonTextTitle, for: .normal)
        btnCheckLiveness.setTitleColor(SpoofSense.buttonTitleColor, for: .normal)
        btnCheckLiveness.backgroundColor = SpoofSense.buttonBackgroundColor
    }
}

//MARK: Action
private extension SplaceViewController {
    @IBAction func onBtnCheckLiveness(_ sender: UIButton) {
        if self.navigationController == nil {
            self.dismiss(animated: SpoofSense.isNaigationControllerAnimated) {
                if SpoofSense.showFaceGuidelinesScreen {
                    let podBundle = Bundle(for: FaceGuidelinesViewController.self)
                    let storyBoard = UIStoryboard.init(name: "SpoofSense", bundle: podBundle)
                    let vc = storyBoard.instantiateViewController(withIdentifier: "FaceGuidelinesViewController") as? FaceGuidelinesViewController
                    SpoofSense.navigation?.pushViewController(vc!, animated: SpoofSense.isNaigationControllerAnimated)
                } else {
                    let podBundle = Bundle(for: CameraViewController.self)
                    let storyBoard = UIStoryboard.init(name: "SpoofSense", bundle: podBundle)
                    let vc = storyBoard.instantiateViewController(withIdentifier: "CameraViewController") as? CameraViewController
                    SpoofSense.navigation?.pushViewController(vc!, animated: SpoofSense.isNaigationControllerAnimated)
                }
                
            }
        } else {
            if SpoofSense.showFaceGuidelinesScreen {
                let podBundle = Bundle(for: FaceGuidelinesViewController.self)
                let storyBoard = UIStoryboard.init(name: "SpoofSense", bundle: podBundle)
                let vc = storyBoard.instantiateViewController(withIdentifier: "FaceGuidelinesViewController") as? FaceGuidelinesViewController
                self.navigationController?.pushViewController(vc!, animated: SpoofSense.isNaigationControllerAnimated)
            } else {
                let podBundle = Bundle(for: CameraViewController.self)
                let storyBoard = UIStoryboard.init(name: "SpoofSense", bundle: podBundle)
                let vc = storyBoard.instantiateViewController(withIdentifier: "CameraViewController") as? CameraViewController
                self.navigationController?.pushViewController(vc!, animated: SpoofSense.isNaigationControllerAnimated)
            }
        }
    }
}

//
//  SetCustomUI.swift
//  spoof-sense-ios
//
//  Created by iMac on 10/02/23.
//

import Foundation
import UIKit

public var SpoofSense = SpoofSenseUIConfig()
let webUrl = "https://rah9bywlua.execute-api.ap-south-1.amazonaws.com/prod/antispoofing"

public class SpoofSenseUIConfig {
    public var resultCallBack:(([String:Any]) -> ())?
    
    private var _appFirstName = "Spoof"
    private var _apiKey = "Ek5Bnc6Aqx1W9Ye2JXf2G6w6u2sjRjvOaNK79z39"
    private var _guidelinesButtonTextTitle = "Check Liveness"
    private var _splashButtonTextTitle = "Check Liveness"
    private var _buttonTitleColor = UIColor(named: "Button_Text_Color_FFFFFF") ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    private var _buttonBackgroundColor = UIColor(named: "Button_BG_Color_0E68C0") ?? #colorLiteral(red: 0.05490196078, green: 0.4078431373, blue: 0.7529411765, alpha: 1)
    private var _showSplashScreen = true
    private var _showFaceGuidelinesScreen = true
    private var _appLogo = UIImage()
    private var _appFirstNameColor = UIColor(named: "Button_BG_Color_0E68C0") ?? #colorLiteral(red: 0.05490196078, green: 0.4078431373, blue: 0.7529411765, alpha: 1)
    private var _appLastNameColor = UIColor(named: "Text_Color_222222") ?? #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
    private var _appLastName = "Sense"
    private var _versionNumberString = "face V1.1.2"
    private var _versionNumberColor = UIColor(named: "Text_Color_222222") ?? #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
    public var isNaigationControllerPresent = false
    public var isNaigationControllerAnimated = true
    public var navigation: UINavigationController?
    
    public var apiKey: String {
        get {
            return _apiKey
        }
        set {
            self._apiKey = newValue
        }
    }
    
    public var appFirstName: String {
        set {
            _appFirstName = newValue
        }
        get {
            return _appFirstName
        }
    }
    
    public var guidelinesButtonTextTitle: String {
        get {
            return _guidelinesButtonTextTitle
        }
        set {
            self._guidelinesButtonTextTitle = newValue
        }
    }
    
    public var splashButtonTextTitle: String {
        get {
            return _splashButtonTextTitle
        }
        set {
            self._splashButtonTextTitle = newValue
        }
    }
    
    public var buttonTitleColor: UIColor {
        get {
            return _buttonTitleColor
        }
        set {
            self._buttonTitleColor = newValue
        }
    }
    
    public var buttonBackgroundColor: UIColor {
        get {
            return _buttonBackgroundColor
        }
        set {
            self._buttonBackgroundColor = newValue
        }
    }
    
    public var showFaceGuidelinesScreen: Bool {
        get {
            return _showFaceGuidelinesScreen
        }
        set {
            self._showFaceGuidelinesScreen = newValue
        }
    }
    
    public var showSplashScreen: Bool {
        get {
            return _showSplashScreen
        }
        set {
            self._showSplashScreen = newValue
        }
    }
    
    public var appLogo: UIImage {
        get {
            let podBundle = Bundle(for: SplaceViewController.self)
            let image = UIImage(named: "ic_splace_logo", in: podBundle, compatibleWith: nil)
            _appLogo = image!
            return image!
        }
        set {
            _appLogo = newValue
        }
    }
    
    public var appFirstNameColor: UIColor {
        get {
            return _appFirstNameColor
        }
        set {
            self._appFirstNameColor = newValue
        }
    }
    
    public var appLastNameColor: UIColor {
        get {
            return _appLastNameColor
        }
        set {
            self._appLastNameColor = newValue
        }
    }
    
    public var appLastName: String {
        get {
            return _appLastName
        }
        set {
            self._appLastName = newValue
        }
    }
    
    public var versionNumberString: String {
        get {
            return _versionNumberString
        }
        set {
            self._versionNumberString = newValue
        }
    }
    
    public var versionNumberColor: UIColor {
        get {
            return _versionNumberColor
        }
        set {
            self._versionNumberColor = newValue
        }
    }
}

//MARK: Navigation
public extension SpoofSenseUIConfig {
    func present(with navigationController: UINavigationController, animated: Bool = true) {
        if _apiKey.isEmpty {
            let jsonObject: [String: Any] = ["message": ResultValue.apiKey.getResultMessage, "liveness": false]
            print("jsonObject: ", jsonObject)
            SpoofSense.resultCallBack?(jsonObject)
            return
        }
        self.isNaigationControllerPresent = true
        self.isNaigationControllerAnimated = animated
        self.navigation = navigationController
        self.navigationController()
    }
    
    func push(with navigationController: UINavigationController) {
        if _apiKey.isEmpty {
            let jsonObject: [String: Any] = ["message": ResultValue.apiKey.getResultMessage, "liveness": false]
            print("jsonObject: ", jsonObject)
            SpoofSense.resultCallBack?(jsonObject)
            return
        }
        self.navigation = navigationController
        self.navigationController()
    }
}

private extension SpoofSenseUIConfig {
    func navigationController() {
        if _apiKey.isEmpty {
            let jsonObject: [String: Any] = ["message": ResultValue.apiKey.getResultMessage, "liveness": false]
            print("jsonObject: ", jsonObject)
            SpoofSense.resultCallBack?(jsonObject)
            return
        }
        if SpoofSense.showSplashScreen {
            let podBundle = Bundle(for: SplaceViewController.self)
            let storyBoard = UIStoryboard.init(name: "SpoofSense", bundle: podBundle)
            let vc = storyBoard.instantiateViewController(withIdentifier: "SplaceViewController") as? SplaceViewController
            if self.isNaigationControllerPresent {
                vc?.modalPresentationStyle = .fullScreen
                self.navigation?.present(vc!, animated: self.isNaigationControllerAnimated, completion: nil)
            } else {
                self.navigation?.pushViewController(vc!, animated: self.isNaigationControllerAnimated)
            }
        } else if SpoofSense.showFaceGuidelinesScreen {
            let podBundle = Bundle(for: FaceGuidelinesViewController.self)
            let storyBoard = UIStoryboard.init(name: "SpoofSense", bundle: podBundle)
            let vc = storyBoard.instantiateViewController(withIdentifier: "FaceGuidelinesViewController") as? FaceGuidelinesViewController
            if self.isNaigationControllerPresent {
                vc?.modalPresentationStyle = .fullScreen
                self.navigation?.present(vc!, animated: self.isNaigationControllerAnimated, completion: nil)
            } else {
                self.navigation?.pushViewController(vc!, animated: self.isNaigationControllerAnimated)
            }
        } else {
            let podBundle = Bundle(for: FaceGuidelinesViewController.self)
            let storyBoard = UIStoryboard.init(name: "SpoofSense", bundle: podBundle)
            let vc = storyBoard.instantiateViewController(withIdentifier: "CameraViewController") as? CameraViewController
            if self.isNaigationControllerPresent {
                vc?.modalPresentationStyle = .fullScreen
                self.navigation?.present(vc!, animated: self.isNaigationControllerAnimated, completion: nil)
            } else {
                self.navigation?.pushViewController(vc!, animated: self.isNaigationControllerAnimated)
            }
        }
    }
}

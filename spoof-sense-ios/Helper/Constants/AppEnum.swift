//
//  AppEnum.swift
//  spoof-sense-ios
//
//  Created by iMac on 09/02/23.
//

import Foundation
import UIKit

enum UserDefaultKeys: String {
    case isUserSetApiKey    = "IsUserSetApiKey"
    case userRegisterApiKey = "UserRegisterApiKey"
}

public enum SelecteLaunchScreen {
    case openSplaceScreen
    case openGuidelinesScreen
    case openCameraScreen
}

enum ResultValue: String, CaseIterable {
    case real   = "real"
    case spoof  = "spoof"
    case apiKey  = "apiKey"
    
    var getResultMessage: String {
        switch self {
        case .real:
            return "Liveness Confirmed"
        case .spoof:
            return "Please try again. Make sure the selfie is captured in proper lighting."
        case .apiKey:
            return "Api key is missing."
        }
    }
}

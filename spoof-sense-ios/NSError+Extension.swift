//
//  NSError+Extension.swift
//  spoof-sense-ios
//
//  Created by iMac on 09/02/23.
//

import Foundation
import UIKit

extension NSError {
    convenience init(localizedDescription : String) {
        self.init(domain: "AppNetworkingError", code: 0, userInfo: [NSLocalizedDescriptionKey : localizedDescription])
    }
    
    convenience init(code : Int, localizedDescription : String) {
        self.init(domain: "AppNetworkingError", code: code, userInfo: [NSLocalizedDescriptionKey : localizedDescription])
    }
}

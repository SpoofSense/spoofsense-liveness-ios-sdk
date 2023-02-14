//
//  ResultCameraViewModel.swift
//  spoof-sense-ios
//
//  Created by iMac on 09/02/23.
//

import Foundation
import UIKit

typealias SuccessResponseWithString = (_ stringValue : String) -> ()
typealias FailureResponse = (NSError?) -> (Void)

class ResultCameraViewModel {
    
    var base64ImageData = ""
    var jsonObject = [String: Any]()

    func postURLSessionGetData(success: @escaping SuccessResponseWithString, failure: @escaping FailureResponse) {
        let apiKey = SpoofSense.apiKey
        if apiKey.isEmpty {
            self.jsonObject = ["message": ResultValue.apiKey.getResultMessage, "status": false]
            failure(NSError(localizedDescription: ResultValue.apiKey.getResultMessage))
        }
        let parameters = ["data": base64ImageData]
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        var request = URLRequest(url: URL(string: webUrl)!,timeoutInterval: Double.infinity)
        request.addValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                failure(error as NSError?)
                self.jsonObject = ["message": error?.localizedDescription ?? "", "status": false]
                return
            }
            DispatchQueue.main.async {
                if let jsonData = try? (JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]) {
                    if let detaill = jsonData["detail"] as? String {
                        failure(NSError(localizedDescription: detaill))
                        self.jsonObject = ["message": detaill, "status": false]
                    } else {
                        guard let detaill = jsonData["message"] as? String, detaill.lowercased() != "Forbidden".lowercased()  else {
                            self.jsonObject = ["message": ResultValue.apiKey.getResultMessage, "status": false]
                            failure(NSError(localizedDescription: ResultValue.apiKey.getResultMessage))
                            return
                        }
                        let model_output = jsonData["model_output"] as! [String: Any]
                        if let pred_idx = model_output["pred_idx"] as? String, let resultValue = ResultValue(rawValue: pred_idx) {
                            switch resultValue {
                            case .real:
                                self.jsonObject = ["message": resultValue.getResultMessage, "status": true]
                                success(resultValue.getResultMessage)
                            case .spoof:
                                self.jsonObject = ["message": resultValue.getResultMessage, "status": false]
                                failure(NSError(localizedDescription: resultValue.getResultMessage))
                            case .apiKey:
                                self.jsonObject = ["message": ResultValue.apiKey.getResultMessage, "status": false]
                                failure(NSError(localizedDescription: ResultValue.apiKey.getResultMessage))
                                break
                            }
                        } else {
                            self.jsonObject = ["message": detaill, "status": true]
                            success(detaill)
                        }
                        
                    }
                } else {
                    failure(NSError(localizedDescription: "No face found in the image, please ensure the submitted image meets the requirements."))
                }
            }
        }
        task.resume()
    }
}

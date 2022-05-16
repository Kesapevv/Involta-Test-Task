//
//  Networking.swift
//  InvoltaTestTask
//
//  Created by Vadim Voronkov on 06.05.2022.
//

import Foundation
import Alamofire
import UIKit

class Networking {
    
    static func FetchData(offset: Int, completionHandler: @escaping (Bool) -> ()) {
        AF.request("https://numero-logy-app.org.in/getMessages?offset=\(offset)", method: .get).validate().responseDecodable(of: Messages.self) { response in
            
            switch response.result {
            case .success(let message):
                print("result is - \(message)")
            case .failure(let error):
                print(error)
                completionHandler(false)
            }
            
            if let value = response.value {
                for i in value.messages {
                    Messages.shared.messages.append(i)
                }
                if value.messages.isEmpty {
                    completionHandler(false)
                } else {
                    completionHandler(true)
                }
            }
        }
        
    }
}

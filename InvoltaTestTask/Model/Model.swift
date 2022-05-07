//
//  Model.swift
//  InvoltaTestTask
//
//  Created by Vadim Voronkov on 06.05.2022.
//

import Foundation

struct Messages: Codable {
    
    static var shared = Messages()
    
    var messages = [String]()
    
    enum CodingKeys: String, CodingKey {
             case messages = "result"
       }
}

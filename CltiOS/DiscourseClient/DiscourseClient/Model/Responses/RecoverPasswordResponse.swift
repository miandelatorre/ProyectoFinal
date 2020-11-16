//
//  RecoverPasswordResponse.swift
//  DiscourseClient
//
//  Created by Miguel Angel de la Torre on 14/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct RecoverPasswordResponse: Codable {
    let success: String
    let userFound: Bool
    
    enum CodingKeys: String, CodingKey {
        case success
        case userFound = "user_found"
    }
}

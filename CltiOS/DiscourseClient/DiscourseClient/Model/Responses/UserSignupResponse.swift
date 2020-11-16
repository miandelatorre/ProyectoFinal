//
//  UserSignupResponse.swift
//  DiscourseClient
//
//  Created by Miguel Angel de la Torre on 13/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct UserSignupResponse: Codable {
    let success: Bool
    let active: Bool
    let message: String
    let userId: Int
    
    enum CodingKeys: String, CodingKey {
        case success
        case active
        case message
        case userId = "user_id"
    }
}

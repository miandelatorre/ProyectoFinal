//
//  UserSignupRequest.swift
//  DiscourseClient
//
//  Created by Miguel Angel de la Torre on 13/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

class UserSignupRequest: APIRequest {
    typealias Response = UserSignupResponse

    let email: String
    let username: String
    let password: String

    init(email: String, username: String, password: String) {
        self.email = email
        self.username = username
        self.password = password
    }

    var method: Method {
        return .POST
    }

    var path: String {
        return "/users"
    }

    var parameters: [String : String] {
        return [:]
    }

    var body: [String : Any] {
        return ["name": username,
                "email": email,
                "password": password,
                "username": username]
    }

    var headers: [String : String] {
        return [:]
    }
}

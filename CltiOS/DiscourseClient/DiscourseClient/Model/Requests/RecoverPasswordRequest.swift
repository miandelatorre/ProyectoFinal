//
//  RecoverPasswordRequest.swift
//  DiscourseClient
//
//  Created by Miguel Angel de la Torre on 14/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

class RecoverPasswordRequest: APIRequest {
    typealias Response = RecoverPasswordResponse

    let email: String

    init(email: String) {
        self.email = email
    }

    var method: Method {
        return .POST
    }

    var path: String {
        return "/session/forgot_password"
    }

    var parameters: [String : String] {
        return [:]
    }

    var body: [String : Any] {
        return ["login": email]
    }

    var headers: [String : String] {
        return [:]
    }
}

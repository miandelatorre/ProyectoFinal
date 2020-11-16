//
//  UserSignupDataManager.swift
//  DiscourseClient
//
//  Created by Miguel Angel de la Torre on 13/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol UserSignupDataManager: class {
    func userSignup(email: String, username: String, password: String, completion: @escaping (Result<UserSignupResponse?, Error>) -> ())
}

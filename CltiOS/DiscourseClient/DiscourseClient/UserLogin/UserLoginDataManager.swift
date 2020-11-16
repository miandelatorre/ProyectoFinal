//
//  UserLoginDataManager.swift
//  DiscourseClient
//
//  Created by Miguel Angel de la Torre on 11/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol UserLoginDataManager: class {
    func fetchUserLogIn(username: String, completion: @escaping (Result<UserResponse?, Error>) -> ())
 }

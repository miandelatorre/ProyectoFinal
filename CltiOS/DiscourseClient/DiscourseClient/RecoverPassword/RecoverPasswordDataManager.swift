//
//  RecoverPasswordDataManager.swift
//  DiscourseClient
//
//  Created by Miguel Angel de la Torre on 14/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol RecoverPasswordDataManager: class {

    func recoverPassword(email: String, completion: @escaping (Result<RecoverPasswordResponse?, Error>) -> ())

}

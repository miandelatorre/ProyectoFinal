//
//  UserSignupViewModel.swift
//  DiscourseClient
//
//  Created by Miguel Angel de la Torre on 13/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate a través del cual nos vamos a comunicar con el coordinator, contándole todo aquello que atañe a la navegación
protocol UserSignupCoordinatorDelegate: class {
    func loginButtonTapped()
}

protocol UserSignupViewModelViewDelegate: class {
    func errorSigningUpUser()
    func successSigningUpUser()
}

class UserSignupViewModel {
    weak var coordinatorDelegate: UserSignupCoordinatorDelegate?
    weak var viewDelegate: UserSignupViewModelViewDelegate?
    let userSignupDataManager: UserSignupDataManager

    var userIDLabelText: String?
    var nameLabelText: String?
    var userNameUsingTextFieldStackViewIsHidden = true
    var updateNameButtonIsHidden = true

    init(userSignupDataManager: UserSignupDataManager) {
        self.userSignupDataManager = userSignupDataManager
    }

    func viewWasLoaded() {
    }

    func signupButtonTapped(email: String, userName: String, password: String) {

        userSignupDataManager.userSignup(email: email, username: userName, password: password) { [weak self] (result) in
            switch result {
            case .success:
                self?.viewDelegate?.successSigningUpUser()
            case .failure:
                self?.viewDelegate?.errorSigningUpUser()
            }
        }

    }
    
    func loginButtonTapped() {
        coordinatorDelegate?.loginButtonTapped()
    }
    
}

//
//  UserLoginViewModel.swift
//  DiscourseClient
//
//  Created by Miguel Angel de la Torre on 11/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate a través del cual nos vamos a comunicar con el coordinator, contándole todo aquello que atañe a la navegación
protocol UserLoginCoordinatorDelegate: class {
    func logInSuccessfullyFinished()
    func createAccountButtonTapped()
    func recoverPasswordButtonTapped()
}

protocol UserLoginViewModelViewDelegate: class {
    func errorFetchingUser()
}

class UserLoginViewModel {
    weak var coordinatorDelegate: UserLoginCoordinatorDelegate?
    weak var viewDelegate: UserLoginViewModelViewDelegate?
    let userLoginDataManager: UserLoginDataManager

    init(userLoginDataManager: UserLoginDataManager) {
        self.userLoginDataManager = userLoginDataManager
    }

    func viewWasLoaded() {
    }

    func loginButtonTapped(name: String) {

        userLoginDataManager.fetchUserLogIn(username: name) { [weak self] (result) in
            switch result {
            case .success:
                self?.coordinatorDelegate?.logInSuccessfullyFinished()
            case .failure:
                self?.viewDelegate?.errorFetchingUser()
            }
        }
    }
    
    func createAccountButtonTapped() {
        coordinatorDelegate?.createAccountButtonTapped()
    }
    
    func recoverPasswordButtonTapped() {
        coordinatorDelegate?.recoverPasswordButtonTapped()
    }
}

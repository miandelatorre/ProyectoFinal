//
//  RecoverPasswordViewModel.swift
//  DiscourseClient
//
//  Created by Miguel Angel de la Torre on 14/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate a través del cual nos vamos a comunicar con el coordinator, contándole todo aquello que atañe a la navegación
protocol RecoverPasswordCoordinatorDelegate: class {
    func loginButtonTapped()
}

protocol RecoverPasswordViewModelViewDelegate: class {
    func errorRecoveringPassword()
    func errorUserNotFound()
    func successRecoveringPassword()
}

class RecoverPasswordViewModel {
    weak var coordinatorDelegate: RecoverPasswordCoordinatorDelegate?
    weak var viewDelegate: RecoverPasswordViewModelViewDelegate?
    let recoverPasswordDataManager: RecoverPasswordDataManager

    var userIDLabelText: String?
    var nameLabelText: String?
    var userNameUsingTextFieldStackViewIsHidden = true
    var updateNameButtonIsHidden = true

    init(recoverPasswordDataManager: RecoverPasswordDataManager) {
        self.recoverPasswordDataManager = recoverPasswordDataManager
    }

    func viewWasLoaded() {
    }

    func recoverPasswordButtonTapped(email: String) {

        recoverPasswordDataManager.recoverPassword(email: email) { [weak self] (result) in
            switch result {
            case .success(let response):
                if response?.userFound ?? false {
                    self?.viewDelegate?.successRecoveringPassword()
                } else {
                    self?.viewDelegate?.errorUserNotFound()
                }
            case .failure:
                self?.viewDelegate?.errorRecoveringPassword()
            }
        }

    }
    
    func loginButtonTapped() {
        coordinatorDelegate?.loginButtonTapped()
    }
    
}

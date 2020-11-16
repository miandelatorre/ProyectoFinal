//
//  UserSignupCoordinator.swift
//  DiscourseClient
//
//  Created by Miguel Angel de la Torre on 13/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserSignupCoordinator: Coordinator {
    let presenter: UINavigationController
    let userSignupDataManager: UserSignupDataManager
    var userSignupNavigationController: UINavigationController?
    var onSigninTapped: (() -> Void)?
    var onSignupTapped: (() -> Void)?


    init(presenter: UINavigationController, userSignupDataManager: UserSignupDataManager) {
        self.userSignupDataManager = userSignupDataManager
        self.presenter = presenter
    }

    override func start() {
        let userSignupViewModel = UserSignupViewModel(userSignupDataManager: userSignupDataManager)
        userSignupViewModel.coordinatorDelegate = self
        let userSignupViewController = UserSignupViewController(viewModel: userSignupViewModel)
        userSignupViewModel.viewDelegate = userSignupViewController
        
        userSignupViewController.isModalInPresentation = true
        userSignupViewController.title = "Sign Up"
        
        let navigationController = UINavigationController(rootViewController: userSignupViewController)
        self.userSignupNavigationController = navigationController
        presenter.present(navigationController, animated: true, completion: nil)
    }

    override func finish() {
        userSignupNavigationController?.dismiss(animated: true, completion: nil)
    }
}

extension UserSignupCoordinator: UserSignupCoordinatorDelegate {
    
    func loginButtonTapped() {
        finish()
    }
    
}



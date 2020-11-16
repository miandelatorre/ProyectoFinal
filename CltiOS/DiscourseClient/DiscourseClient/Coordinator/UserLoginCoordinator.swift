//
//  UsersCoordinator.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 28/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserLoginCoordinator: Coordinator {
    let presenter: UINavigationController
    let userLoginDataManager: UserLoginDataManager
    let userSignupDataManager: UserSignupDataManager
    let recoverPasswordDataManager: RecoverPasswordDataManager
    var userLoginNavigationController: UINavigationController?
    var onLogInFinished: (() -> Void)?


    init(presenter: UINavigationController, userLoginDataManager: UserLoginDataManager,
        userSignupDataManager:
        UserSignupDataManager,
        recoverPasswordDataManager:
        RecoverPasswordDataManager) {
        self.presenter = presenter
        self.userLoginDataManager = userLoginDataManager
        self.userSignupDataManager = userSignupDataManager
        self.recoverPasswordDataManager = recoverPasswordDataManager
    }

    override func start() {
        let userLoginViewModel = UserLoginViewModel(userLoginDataManager: userLoginDataManager)
        userLoginViewModel.coordinatorDelegate = self
        let userLoginViewController = UserLoginViewController(viewModel: userLoginViewModel)
        userLoginViewModel.viewDelegate = userLoginViewController
        
        userLoginViewController.isModalInPresentation = true
        userLoginViewController.title = "Log In"
        
        let navigationController = UINavigationController(rootViewController: userLoginViewController)
        self.userLoginNavigationController = navigationController
        presenter.present(navigationController, animated: true, completion: nil)
    }

    override func finish() {
        userLoginNavigationController?.dismiss(animated: true, completion: nil)
    }
}

extension UserLoginCoordinator: UserLoginCoordinatorDelegate {
 
    func logInSuccessfullyFinished() {
        onLogInFinished?()
    }
    
    func createAccountButtonTapped() {
         
        guard let userLoginNavigationController = userLoginNavigationController else {
            return
        }
        
         let userSignupCoordinator = UserSignupCoordinator(presenter: userLoginNavigationController, userSignupDataManager: userSignupDataManager)
         addChildCoordinator(userSignupCoordinator)
         userSignupCoordinator.start()

         userSignupCoordinator.onSigninTapped = { [weak self] in
             guard let self = self else { return }

             userSignupCoordinator.finish()
             self.removeChildCoordinator(userSignupCoordinator)
         }
    }

    func recoverPasswordButtonTapped() {
         
        guard let userLoginNavigationController = userLoginNavigationController else {
            return
        }
        
         let recoverPasswordCoordinator = RecoverPasswordCoordinator(presenter: userLoginNavigationController, recoverPasswordDataManager: recoverPasswordDataManager)
         addChildCoordinator(recoverPasswordCoordinator)
         recoverPasswordCoordinator.start()
            
         recoverPasswordCoordinator.onSigninTapped = { [weak self] in
             guard let self = self else { return }

             recoverPasswordCoordinator.finish()
             self.removeChildCoordinator(recoverPasswordCoordinator)
         }
        
    }

}


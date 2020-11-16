//
//  RecoverPasswordCoordinator.swift
//  DiscourseClient
//
//  Created by Miguel Angel de la Torre on 14/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class RecoverPasswordCoordinator: Coordinator {
    let presenter: UINavigationController
    let recoverPasswordDataManager: RecoverPasswordDataManager
    var recoverPasswordNavigationController: UINavigationController?
    var onSigninTapped: (() -> Void)?
    var onRecoverPasswordTapped: (() -> Void)?

    init(presenter: UINavigationController, recoverPasswordDataManager: RecoverPasswordDataManager) {
        self.presenter = presenter
        self.recoverPasswordDataManager = recoverPasswordDataManager
    }

    override func start() {

        let recoverPasswordViewModel = RecoverPasswordViewModel(recoverPasswordDataManager: recoverPasswordDataManager)
        recoverPasswordViewModel.coordinatorDelegate = self
        let recoverPasswordViewController = RecoverPasswordViewController(viewModel: recoverPasswordViewModel)
        recoverPasswordViewModel.viewDelegate = recoverPasswordViewController
        
        recoverPasswordViewController.isModalInPresentation = true
        recoverPasswordViewController.title = "Recover Password"
        
        let navigationController = UINavigationController(rootViewController: recoverPasswordViewController)
        self.recoverPasswordNavigationController = navigationController
        presenter.present(navigationController, animated: true, completion: nil)

    }

    override func finish() {

        recoverPasswordNavigationController?.dismiss(animated: true, completion: nil)
 
    }

}

extension RecoverPasswordCoordinator: RecoverPasswordCoordinatorDelegate {
    
    func loginButtonTapped() {
        finish()
    }
    
}



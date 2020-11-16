//
//  AddPostCoordinator.swift
//  DiscourseClient
//
//  Created by Miguel Angel de la Torre on 14/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Coordinator del módulo add topic.
class AddPostCoordinator: Coordinator {
    let presenter: UINavigationController
    let addPostDataManager: AddPostDataManager
    var addPostNavigationController: UINavigationController?
    var onCancelTapped: (() -> Void)?
    var onPostCreated: (() -> Void)?
    var topicID: Int
    
    init(presenter: UINavigationController, topicID: Int, addPostDataManager: AddPostDataManager) {
        self.presenter = presenter
        self.topicID = topicID
        self.addPostDataManager = addPostDataManager
    }

    override func start() {
        let addPostViewModel = AddPostViewModel(topicID: topicID, dataManager: addPostDataManager)
        addPostViewModel.coordinatorDelegate = self

        let addPostViewController = AddPostViewController(viewModel: addPostViewModel)
        addPostViewModel.viewDelegate = addPostViewController
        addPostViewController.isModalInPresentation = true
        addPostViewController.title = "Create post"

        let navigationController = UINavigationController(rootViewController: addPostViewController)
        self.addPostNavigationController = navigationController
        presenter.present(navigationController, animated: true, completion: nil)
    }

    override func finish() {
        presenter.popViewController(animated: true)
    }
}

extension AddPostCoordinator: AddPostCoordinatorDelegate {
    func addPostCancelButtonTapped() {
        onCancelTapped?()
    }

    func postSuccessfullyAdded() {
        onPostCreated?()
    }
}

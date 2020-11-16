//
//  TopicsCoordinator.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Coordinator que representa la pila de navegación del topics list.
/// Tiene como hijo el AddTopicCoordinator
class TopicsCoordinator: Coordinator {
    let presenter: UINavigationController
    let topicsDataManager: TopicsDataManager
    let topicDetailDataManager: TopicDetailDataManager
    let addTopicDataManager: AddTopicDataManager
    let addPostDataManager: AddPostDataManager
    var topicsViewModel: TopicsViewModel?

    init(presenter: UINavigationController, topicsDataManager: TopicsDataManager,
         topicDetailDataManager: TopicDetailDataManager,
         addTopicDataManager: AddTopicDataManager,
         addPostDataManager: AddPostDataManager) {

        self.presenter = presenter
        self.topicsDataManager = topicsDataManager
        self.topicDetailDataManager = topicDetailDataManager
        self.addTopicDataManager = addTopicDataManager
        self.addPostDataManager = addPostDataManager
    }

    override func start() {
        let topicsViewModel = TopicsViewModel(topicsDataManager: topicsDataManager)
        let topicsViewController = TopicsViewController(viewModel: topicsViewModel)
        topicsViewController.title = NSLocalizedString("Topics", comment: "")
        topicsViewModel.viewDelegate = topicsViewController
        topicsViewModel.coordinatorDelegate = self
        self.topicsViewModel = topicsViewModel
        presenter.pushViewController(topicsViewController, animated: false)
    }

    override func finish() {}
}

extension TopicsCoordinator: TopicsCoordinatorDelegate {
    func didSelect(topic: Topic) {
        let topicDetailViewModel = TopicDetailViewModel(topicID: topic.id, topicDetailDataManager: topicDetailDataManager)
        topicDetailViewModel.coordinatorDelegate = self
        let topicDetailViewController = TopicDetailViewController(viewModel: topicDetailViewModel)
        topicDetailViewModel.viewDelegate = topicDetailViewController
        presenter.pushViewController(topicDetailViewController, animated: true)
    }

    func topicsPlusButtonTapped() {
        let addTopicCoordinator = AddTopicCoordinator(presenter: presenter, addTopicDataManager: addTopicDataManager)
        addChildCoordinator(addTopicCoordinator)
        addTopicCoordinator.start()

        addTopicCoordinator.onCancelTapped = { [weak self] in
            guard let self = self else { return }

            addTopicCoordinator.finish()
            self.removeChildCoordinator(addTopicCoordinator)
        }

        addTopicCoordinator.onTopicCreated = { [weak self] in
            guard let self = self else { return }

            addTopicCoordinator.finish()
            self.removeChildCoordinator(addTopicCoordinator)
            self.topicsViewModel?.newTopicWasCreated()
        }
    }
}

extension TopicsCoordinator: TopicDetailCoordinatorDelegate {
    func topicDetailBackButtonTapped() {
        presenter.popViewController(animated: true)
    }
    
    func newPostButtonTapped(topicID: Int) {
        presenter.popViewController(animated: false)
        let addPostViewModel = AddPostViewModel(topicID: topicID, dataManager: addPostDataManager)
        let addPostCoordinator = AddPostCoordinator(presenter: presenter, topicID: topicID, addPostDataManager: addPostDataManager)
        
        addChildCoordinator(addPostCoordinator)
        
        addPostCoordinator.onCancelTapped = { [weak self] in
            guard let self = self else { return }

            addPostCoordinator.finish()
            self.removeChildCoordinator(addPostCoordinator)
        }

        addPostCoordinator.onPostCreated = { [weak self] in
            guard let self = self else { return }

            addPostCoordinator.finish()
            self.removeChildCoordinator(addPostCoordinator)
            self.topicsViewModel?.newPostWasCreated()
        }
        
        addPostViewModel.coordinatorDelegate = addPostCoordinator
        let addPostViewController = AddPostViewController(viewModel: addPostViewModel)
        addPostViewModel.viewDelegate = addPostViewController
        
        presenter.pushViewController(addPostViewController, animated: true)
    }

    func topicSuccessfullyDeleted() {
        presenter.popViewController(animated: true)
        topicsViewModel?.topicWasDeleted()
    }
}


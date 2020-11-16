//
//  AddPostViewModel.swift
//  DiscourseClient
//
//  Created by Miguel Angel de la Torre on 14/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate para comunicar aspectos relacionados con navegación
protocol AddPostCoordinatorDelegate: class {
    func addPostCancelButtonTapped()
    func postSuccessfullyAdded()
}

/// Delegate para comunicar a la vista aspectos relacionados con UI
protocol AddPostViewDelegate: class {
    func successAddingPost()
    func errorAddingPost()
}

class AddPostViewModel {
    weak var viewDelegate: AddPostViewDelegate?
    var coordinatorDelegate: AddPostCoordinatorDelegate?
    let dataManager: AddPostDataManager
    let topicID: Int

    init(topicID: Int, dataManager: AddPostDataManager) {
        self.topicID = topicID
        self.dataManager = dataManager
    }

    func cancelButtonTapped() {
        coordinatorDelegate?.addPostCancelButtonTapped()
    }

    func submitButtonTapped(post: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let createdAt = dateFormatter.string(from: Date())

        dataManager.addPost(topicID: topicID, post: post, raw: post, createdAt: createdAt) { [weak self] (result) in
            switch result {
            case .success:
                self?.coordinatorDelegate?.postSuccessfullyAdded()
//              self?.viewDelegate?.successAddingPost()
            case .failure:
                self?.viewDelegate?.errorAddingPost()
            }
        }
    }
}

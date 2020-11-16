//
//  AddPostDataManager.swift
//  DiscourseClient
//
//  Created by Miguel Angel de la Torre on 14/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol AddPostDataManager: class {
    func addPost(topicID: Int, post: String, raw: String, createdAt: String, completion: @escaping (Result<AddNewPostResponse?, Error>) -> ())
}

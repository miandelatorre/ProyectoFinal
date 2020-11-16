//
//  CreatePostRequest.swift
//  DiscourseClient
//
//  Created by Miguel Angel de la Torre on 14/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct CreatePostRequest: APIRequest {

    typealias Response = AddNewPostResponse

    let topicID: Int
    let post: String
    let raw: String
    let createdAt: String

    init(topicID: Int,
         post: String,
         raw: String,
         createdAt: String) {
        self.topicID = topicID
        self.post = post
        self.raw = raw
        self.createdAt = createdAt
    }

    var method: Method {
        return .POST
    }

    var path: String {
        return "/posts.json"
    }

    var parameters: [String : String] {
        return [:]
    }

    var body: [String : Any] {
        return ["title": post,
                "topic_id": topicID,
                "raw": raw,
                "created_at": createdAt]
    }

    var headers: [String : String] {
        return [:]
    }
}

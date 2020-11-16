//
//  DiscourseClientDataManager.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation


/// DataManager de la app. Usa un localDataManager y un remoteDataManager que colaboran entre ellos
/// En las extensiones de abajo, encontramos la implementación de aquellos métodos necesarios en cada módulo de la app
/// Este DataManager sólo utiliza llamadas remotas, pero podría extenderse para serialziar las respuestas, y poder implementar un offline first en el futuro
class DiscourseClientDataManager {
    let localDataManager: DiscourseClientLocalDataManager
    let remoteDataManager: DiscourseClientRemoteDataManager

    init(localDataManager: DiscourseClientLocalDataManager, remoteDataManager: DiscourseClientRemoteDataManager) {
        self.localDataManager = localDataManager
        self.remoteDataManager = remoteDataManager
    }
}

extension DiscourseClientDataManager: TopicsDataManager {
    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse?, Error>) -> ()) {
        remoteDataManager.fetchAllTopics(completion: completion)
    }
}

extension DiscourseClientDataManager: TopicDetailDataManager {
    func fetchTopic(id: Int, completion: @escaping (Result<SingleTopicResponse?, Error>) -> ()) {
        remoteDataManager.fetchTopic(id: id, completion: completion)
    }

    func deleteTopic(id: Int, completion: @escaping (Result<DeleteTopicResponse?, Error>) -> ()) {
        remoteDataManager.deleteTopic(id: id, completion: completion)
    }
}

extension DiscourseClientDataManager: AddTopicDataManager {
    func addTopic(title: String, raw: String, createdAt: String, completion: @escaping (Result<AddNewTopicResponse?, Error>) -> ()) {
        remoteDataManager.addTopic(title: title, raw: raw, createdAt: createdAt, completion: completion)
    }
}

extension DiscourseClientDataManager: AddPostDataManager {
    func addPost(topicID: Int, post: String, raw: String, createdAt: String, completion: @escaping (Result<AddNewPostResponse?, Error>) -> ()) {
        remoteDataManager.addPost(topicID: topicID, post: post, raw: raw, createdAt: createdAt, completion: completion)
    }
}

extension DiscourseClientDataManager: UserLoginDataManager {
   func fetchUserLogIn(username: String, completion: @escaping (Result<UserResponse?, Error>) -> ()) {
       remoteDataManager.fetchUser(username: username, completion: completion)
   }

}

extension DiscourseClientDataManager: UserSignupDataManager {
   func userSignup(email: String, username: String, password: String, completion: @escaping (Result<UserSignupResponse?, Error>) -> ()) {
    remoteDataManager.userSignup(email: email, username: username, password: password, completion: completion)
   }
}

extension DiscourseClientDataManager: UsersDataManager {
    func fetchAllUsers(completion: @escaping (Result<UsersResponse?, Error>) -> ()) {
        remoteDataManager.fetchAllUsers(completion: completion)
    }
}

extension DiscourseClientDataManager: UserDataManager {
    func fetchUser(username: String, completion: @escaping (Result<UserResponse?, Error>) -> ()) {
        remoteDataManager.fetchUser(username: username, completion: completion)
    }

    func updateUserName(username: String, name: String, completion: @escaping (Result<UpdateUserNameResponse?, Error>) -> ()) {
        remoteDataManager.updateUserName(username: username, name: name, completion: completion)
    }

}

extension DiscourseClientDataManager: RecoverPasswordDataManager {        
       func recoverPassword(email: String, completion: @escaping (Result<RecoverPasswordResponse?, Error>) -> ()) {
        remoteDataManager.recoverPassword(email: email, completion: completion)
       }
}





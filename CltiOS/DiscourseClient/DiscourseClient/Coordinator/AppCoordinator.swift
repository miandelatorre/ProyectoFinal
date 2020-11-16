//
//  AppCoordinator.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Coordinator principal de la app. Encapsula todas las interacciones con la Window.
/// Tiene dos hijos, el topic list, y el categories list (uno por cada tab)
class AppCoordinator: Coordinator {
    let sessionAPI = SessionAPI()

    lazy var remoteDataManager: DiscourseClientRemoteDataManager = {
        let remoteDataManager = DiscourseClientRemoteDataManagerImpl(session: sessionAPI)
        return remoteDataManager
    }()

    lazy var localDataManager: DiscourseClientLocalDataManager = {
        let localDataManager = DiscourseClientLocalDataManagerImpl()
        return localDataManager
    }()

    lazy var dataManager: DiscourseClientDataManager = {
        let dataManager = DiscourseClientDataManager(localDataManager: self.localDataManager, remoteDataManager: self.remoteDataManager)
        return dataManager
    }()

    let window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }

    override func start() {
        let tabBarController = UITabBarController()

        let topicsNavigationController = UINavigationController()
        let topicsCoordinator = TopicsCoordinator(presenter: topicsNavigationController,
                                                  topicsDataManager: dataManager,
                                                  topicDetailDataManager: dataManager,
                                                  addTopicDataManager: dataManager,
                                                  addPostDataManager: dataManager)
        addChildCoordinator(topicsCoordinator)
        topicsCoordinator.start()

        let usersNavigationController = UINavigationController()
        let usersCoordinator = UsersCoordinator(presenter: usersNavigationController, usersDataManager: dataManager, userDataManager: dataManager)
        addChildCoordinator(usersCoordinator)
        usersCoordinator.start()

        tabBarController.tabBar.tintColor = UIColor(named: "blue")
        tabBarController.viewControllers = [topicsNavigationController, usersNavigationController]
        tabBarController.tabBar.items?.first?.image = UIImage.init(named: "inicioUnselected")
        tabBarController.tabBar.items?[1].image = UIImage.init(named: "usuariosUnselected")
        tabBarController.tabBar.items?.first?.selectedImage = UIImage.init(named: "inicio")
        tabBarController.tabBar.items?[1].selectedImage = UIImage.init(named: "usuarios")

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        let userLoginCoordinator = UserLoginCoordinator(presenter: topicsNavigationController, userLoginDataManager: dataManager, userSignupDataManager: dataManager,
            recoverPasswordDataManager: dataManager)
        addChildCoordinator(userLoginCoordinator)
        userLoginCoordinator.start()
        
        userLoginCoordinator.onLogInFinished = { [weak self] in
            guard let self = self else { return }

            userLoginCoordinator.finish()
            self.removeChildCoordinator(userLoginCoordinator)
        }

    }

    override func finish() {}
}

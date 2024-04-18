//
//  SceneDelegate.swift
//  BoilerPlate
//
//  Created by user238596 on 10/04/24
//

import UIKit

// MARK: - SceneDelegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo _: UISceneSession,
               options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }

        window = UIWindow(windowScene: windowScene)
        configureApp(to: UserDefaults.isRemember ? .tab : .main)
    }
}

// MARK: - Extension SceneDelegate
extension SceneDelegate {
    private func configureApp(to route: Route) {
        let navigationController = UINavigationController()
        let router = AppRouter(navigationController: navigationController, intialRoute: route)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        Resolver.default.register(type: Router.self) { router }
        registerDependencies()
        router.start()
    }

    /// Register dependencies such as `Repositories`, `Managers` etc.
    private func registerDependencies() {
        Resolver.default.register(type: NetworkService.self) { NetworkManager() }
    }
}

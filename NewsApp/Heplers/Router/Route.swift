//
//  Route.swift
//  SwiftBoilerPlate
//
//  Created by user238596 on 10/04/24
//

import UIKit

// MARK: - Route
enum Route {
    case main
    case success
    case tab
    case home
    case explore
    case profile
}

extension Route {
    var viewController: UIViewController {
        switch self {
        case .main:
            guard let vc = R.storyboard.main.mainVc() else { return UIViewController() }
            return vc
        case .success:
            guard let vc = R.storyboard.main.successVc() else { return UIViewController() }
            return vc
        case .tab:
            guard let vc = R.storyboard.main.tabBarVc() else { return UIViewController() }
            return vc
        case .home:
            guard let vc = R.storyboard.main.homeVc() else { return UIViewController() }
            return vc
        case .explore:
            guard let vc = R.storyboard.main.exploreVc() else { return UIViewController() }
            return vc
        case .profile:
            guard let vc = R.storyboard.main.profileVc() else { return UIViewController() }
            return vc
        }
    }
}

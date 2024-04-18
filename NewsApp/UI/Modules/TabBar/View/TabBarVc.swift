//
//  TabBarVc.swift
//  NewsApp
//
//  Created by user238596 on 10/04/24
//

import UIKit

final class TabBarVc: UITabBarController {
    //MARK: - @IBOutlets
    
    //MARK: - Properties
    
    //MARK: - Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBar()
        delegate = self
    }
    
    //MARK: - @IBActions
    
    //MARK: - Functions
    private func setTabBar() {
        UITabBar.appearance().tintColor = R.color.color_1877F2()
        navigationItem.hidesBackButton = true
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

// MARK: - UITabBarControllerDelegate
extension TabBarVc: UITabBarControllerDelegate {
    func tabBarController(_: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        addTransition(to: viewController)
        return true
    }
}

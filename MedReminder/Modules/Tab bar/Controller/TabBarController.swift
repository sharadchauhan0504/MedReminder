//
//  TabBarController.swift
//  MedReminder
//
//  Created by Sharad on 01/10/20.
//

import UIKit

class TabBarController: UITabBarController {

    //MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // accessibilityIdentifier for UI testing
        view.accessibilityIdentifier = "controller--TabBarController"
        initializeTabBar()
    }
    
    //MARK:- Private methods
    private func initializeTabBar() {
        
        view.backgroundColor   = .black
        tabBar.barTintColor    = .black
        tabBar.backgroundColor = .black
        tabBar.tintColor       = .warmPink

        //DashboardController
        let dashboardController               = DashboardController()
        let dashboardTabBarItem               = UITabBarItem(title: "Home", image: UIImage(named: "") , selectedImage: UIImage(named: ""))
        dashboardController.tabBarItem        = dashboardTabBarItem

        //MedicinesHistoryController
        let medicinesHistoryController        = MedicinesHistoryController()
        let medicinesHistoryTabBarItem        = UITabBarItem(title: "History", image: UIImage(named: "") , selectedImage: UIImage(named: ""))
        medicinesHistoryController.tabBarItem = medicinesHistoryTabBarItem

        viewControllers    = [dashboardController, medicinesHistoryController]
        
        navigationController?.hidesBottomBarWhenPushed = true
    }

}

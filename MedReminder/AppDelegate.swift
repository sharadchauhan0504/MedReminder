//
//  AppDelegate.swift
//  MedReminder
//
//  Created by Sharad on 01/10/20.
//

import UIKit
import CoreData
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let backgroundTaskIdentifier = "com.sharad.MedReminder.handleNotifications"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        NotificationManager.shared.scheduleNotifications()
        
        setRootController()

        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataManager.sharedManager.saveContext()
    }

    //MARK:- Custom methods
    private func setRootController() {
        let splashScreenController                                   = TabBarController()
        let navigationController                                     = UINavigationController(rootViewController: splashScreenController)
        navigationController.isNavigationBarHidden                   = true
        navigationController.view.backgroundColor                    = .white
        navigationController.navigationBar.shadowImage               = UIImage()
        navigationController.navigationBar.tintColor                 = .black
        navigationController.navigationBar.barTintColor              = .white
        navigationController.navigationItem.backBarButtonItem?.title = ""
        window                                                       = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController                                   = navigationController
        window?.makeKeyAndVisible()
    }
    
    
    
}


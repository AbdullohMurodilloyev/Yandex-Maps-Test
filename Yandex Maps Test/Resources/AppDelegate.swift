//
//  AppDelegate.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//

import UIKit
import YandexMapsMobile

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    //static var shared: AppDelegate?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Configure Yandex MapKit
        setupYandexMaps()
        
        // Setup main window
        setupMainWindow()
        
        // Setup main tabbar
        startMainFlow()
        
        
        return true
    }
    
    private func setupYandexMaps() {
        YMKMapKit.setApiKey("522fb9ba-acc3-4c2a-ad64-371448cace44")
        YMKMapKit.sharedInstance()
    }
    
    
    private func setupMainWindow() {
       // Self.shared = self
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
    }
    
    func startMainFlow() {
        let tabBarCoordinator = TabbarCoordinator()
        tabBarCoordinator.start()
        window?.rootViewController = tabBarCoordinator.tabBarController
    }    
    
}


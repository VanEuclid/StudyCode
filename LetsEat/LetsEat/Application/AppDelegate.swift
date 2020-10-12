//
//  AppDelegate.swift
//  LetsEat
//
//  Created by Van Euclid Dy on 9/5/20.
//  Copyright © 2020 Euclidean Software LLC. All rights reserved.
//

import UIKit
import Intents
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initialize()
        return true
    }
    
    func checkNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge, .providesAppNotificationSettings]) { (isGranted, error) in
            if isGranted {
            print("Notifications permissions granted.")
            self.permissionGranted()
        }
        else {
            print("Notifications permissions denied.")
        }}
    }
    
    func permissionGranted() {
        let optionOne = UNNotificationAction(identifier: Option.one.rawValue, title: "Yes", options: [.foreground])
        let optionTwo = UNNotificationAction(identifier: Option.two.rawValue, title: "No", options: [.foreground])
        let hiddenRestaurantPlaceholder = "%u new restaurant invites"
        let summaryFormat = "%u more restaurant invites for %@"
//        let category = UNNotificationCategory(identifier: Identifier.reservationCategory.rawValue, actions: [optionOne, optionTwo], intentIdentifiers: [], options: [])
        
        let category = UNNotificationCategory(identifier: Identifier.reservationCategory.rawValue, actions: [optionOne, optionTwo], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: hiddenRestaurantPlaceholder, categorySummaryFormat: summaryFormat, options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

private extension AppDelegate {
    
    func initialize() {
        setupDefaultColors()
        checkNotifications()
        requestSiriPermissions()
    }
    
    func setupDefaultColors() {
        guard let red = UIColor(named: "LetsEat Red") else {
            return
        }
        UITabBar.appearance().tintColor = red
        UITabBar.appearance().barTintColor = .white
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: UIControl.State.normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: red], for: UIControl.State.selected)
        UINavigationBar.appearance().tintColor = red
        UINavigationBar.appearance().barTintColor = .white
        UITabBar.appearance().isTranslucent = false
        UINavigationBar.appearance().isTranslucent = false 
    }
    
    func requestSiriPermissions() {
        //INPreferences.requestSiriAuthorization({ (status) in print(status) })
    }
}

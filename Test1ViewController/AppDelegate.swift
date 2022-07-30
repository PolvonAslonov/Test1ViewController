//
//  AppDelegate.swift
//  Test1ViewController
//
//  Created by user on 14/07/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window?.rootViewController = UINavigationController(rootViewController: Game15ViewController())
        
        
        return true
        
        
    }
 


}


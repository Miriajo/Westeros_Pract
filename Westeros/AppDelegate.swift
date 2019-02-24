//
//  AppDelegate.swift
//  Westeros
//
//  Created by Alexandre Freire on 31/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var westerosSplitViewController: WesterosSplitViewController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white

        
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons
        
    
        // chequear dispositivo iPad o iPhone
      //  if UIDevice.current.userInterfaceIdiom == .pad {
        
        westerosSplitViewController =  WesterosSplitViewController(houses: houses, seasons: seasons)
        
        window?.rootViewController = westerosSplitViewController
        
      //  }else {
            // Sino, mostramos un tabBar como master
      //      window?.rootViewController = WesterosTabBarController(houses: houses, seasons: seasons)
      //  }

        return true
    }
    
}

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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white

        /*
            CREAR EL SPLIT VIEW PARA HOUSES
        */
        // Creamos los modelos para Houses
        let houses = Repository.local.houses
        // Creamos los controladores (el que irá en master, y el que irá en el detail)
        let houseListViewController = HouseListViewController(model: houses)
        // Recuperar la última casa seleccionada (si hay alguna)
        let lastHouseSelected = houseListViewController.lastSelectedHouse()
        // Crear el controlador Detail de House y Season
        let houseDetailViewController = HouseDetailViewController(model: lastHouseSelected)
        
        // Asigar delegados
        // Un objeto SOLO PUEDE TENER UN DELEGADO
        // Un objeto, puede ser delegado de muchos otros objetos
        houseListViewController.delegate = houseDetailViewController
        
        // Creamos el split view controller y asignamos los controladores
        let houseSplitViewController = UISplitViewController()
        houseSplitViewController.viewControllers = [
                                                houseListViewController.wrappedInNavigation(),
                                                houseDetailViewController.wrappedInNavigation()
                                            ]
        
        
//        window?.rootViewController = splitViewController
        
        /*
         CREAR EL SPLIT VIEW PARA SEASON
         */
        let seasons = Repository.local.seasons
        // Creamos los controladores (el que irá en master, y el que irá en el detail)
        let seasonListViewController = SeasonListViewController(model: seasons)
        // Crear el controlador Detail de House y Season
        let seasonDetailViewController = SeasonDetailViewController(model: seasons.first!)
        
        // Asignar el delegado
        seasonListViewController.delegate = seasonDetailViewController
        
        
        // Creamos el split view controller y asignamos los controladores
        let seasonSplitViewController = UISplitViewController()
        seasonSplitViewController.viewControllers = [
            seasonListViewController.wrappedInNavigation(),
            seasonDetailViewController.wrappedInNavigation()
        ]
        
        
        
        /*
         CREAR EL TAB BAR
         */
        // Crear el UITabBarController y añadirle
        let westerosTabBarController = UITabBarController()
        
        // Añadir los controladores al UITabBar
        let controllers: [UIViewController]
     
        // TODO: controlar si estamos en un iPad o iPhone para hacer el split view
       // controllers = [houseListViewController.wrappedInNavigation(), seasonListViewController.wrappedInNavigation()]
        controllers = [houseSplitViewController, seasonSplitViewController]
        
        // Crear títulos e iconos del UITabBar
        controllers[0].title = "Houses"
        controllers[0].tabBarItem.image = UIImage(named: "Houses")
        controllers[1].title = "Seasons"
        controllers[1].tabBarItem.image = UIImage(named: "Seasons")
        
        westerosTabBarController.viewControllers = controllers
        
        window?.rootViewController = westerosTabBarController
        

        return true
    }
    
}


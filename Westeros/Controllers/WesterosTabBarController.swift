//
//  WesterosTabBarController.swift
//  Westeros
//
//  Created by Casa on 22/2/19.
//  Copyright © 2019 Miriam Sanchez. All rights reserved.
//

import UIKit

class WesterosTabBarController: UITabBarController {

    // MARK: Properties
    var houseListViewController: HouseListViewController
    var lastHouseSelected: House
    var houseDetailViewController: HouseDetailViewController
    var houseSplitViewController: UISplitViewController?
    var houseViewController: UIViewController?
    
    var seasonListViewController: SeasonListViewController
    var lastSeasonSelected: Season
    var seasonDetailViewController: SeasonDetailViewController
    var seasonSplitViewController: UISplitViewController?
        
    init(houses: [House], seasons: [Season]) {
        
        // HOUSES INIT
        // Creamos los controladores (el que irá en master, y el que irá en el detail)
        houseListViewController = HouseListViewController(model: houses)
        // Recuperar la última casa seleccionada (si hay alguna)
        lastHouseSelected = houseListViewController.lastSelectedHouse()
        // Crear el controlador Detail de House y Season
        houseDetailViewController = HouseDetailViewController(model: lastHouseSelected)
        
        // SEASONS INIT
        // Creamos los controladores (el que irá en master, y el que irá en el detail)
        seasonListViewController = SeasonListViewController(model: seasons)
        // Recuperar la última casa seleccionada (si hay alguna)
        lastSeasonSelected = seasonListViewController.lastSelectedSeason()
        // Crear el controlador Detail de House y Season
        seasonDetailViewController = SeasonDetailViewController(model: lastSeasonSelected)
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*
         CREAR EL SPLIT VIEW PARA HOUSES
         */
        housesTabBarViewCreation()
        
        //        window?.rootViewController = splitViewController
        
        /*
         CREAR EL SPLIT VIEW PARA SEASON
         */
       seasonsTabBarViewCreation()
        
        
        /*
         ASIGNAR CONTROLADORES AL TAB BAR
         */
      
        // TODO: controlar si estamos en un iPad o iPhone para hacer el split view
        
        if UIApplication.shared.statusBarOrientation.isLandscape && UIDevice.current.userInterfaceIdiom != .phone {
            // Crear título e icono del UITabBar para HOUSES
            houseSplitViewController!.title = "Houses"
            houseSplitViewController!.tabBarItem.image = UIImage(named: "Houses")
            // Crear título e icono del UITabBar para SEASONS
            seasonSplitViewController?.title = "Seasons"
            seasonSplitViewController?.tabBarItem.image = UIImage(named: "Seasons")

            
            // Añadir los controladores al UITabBar
            viewControllers = [houseSplitViewController, seasonSplitViewController] as? [UIViewController]
        }
        else {
            // Crear título e icono del UITabBar para HOUSES
            houseListViewController.title = "Houses"
            houseListViewController.tabBarItem.image = UIImage(named: "Houses")
            // Crear título e icono del UITabBar para SEASONS
            seasonListViewController.title = "Seasons"
            seasonListViewController.tabBarItem.image = UIImage(named: "Seasons")

            
            viewControllers = [houseListViewController.wrappedInNavigation(), seasonListViewController.wrappedInNavigation()]
        }
        
    }
    
    private func housesTabBarViewCreation() {
        
        
        // Asigar delegados
        // Un objeto SOLO PUEDE TENER UN DELEGADO
        // Un objeto, puede ser delegado de muchos otros objetos
        houseListViewController.delegate = houseDetailViewController
    
        // Creamos el split view controller y asignamos los controladores
        houseSplitViewController = UISplitViewController()
        
        houseSplitViewController?.viewControllers = [
                houseListViewController.wrappedInNavigation(),
                houseDetailViewController.wrappedInNavigation()
                ]
        
    }
    
    private func seasonsTabBarViewCreation() {
        
        
        // Asignar el delegado
        seasonListViewController.delegate = seasonDetailViewController
        
        
        // Creamos el split view controller y asignamos los controladores
        seasonSplitViewController = UISplitViewController()
        seasonSplitViewController?.viewControllers = [
            seasonListViewController.wrappedInNavigation(),
            seasonDetailViewController.wrappedInNavigation()
            ]
        
    }
}

//
//  WesterosSplitViewController.swift
//  Westeros
//
//  Created by Casa on 24/2/19.
//  Copyright © 2019 Miriam Sanchez. All rights reserved.
//

import UIKit

class WesterosSplitViewController: UISplitViewController {

    // MARK: Properties
    var houseListViewController: HouseListViewController
    var lastHouseSelected: House
    var houseDetailViewController: HouseDetailViewController
    
    var seasonListViewController: SeasonListViewController
    var lastSeasonSelected: Season
    var seasonDetailViewController: SeasonDetailViewController
    
    var tabBarViewController = UITabBarController()
    
    // MARK: Inizialization
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
        
        // ASIGNAR CONTROLADORES AL TABBAR
        
        // Crear título e icono del UITabBar para HOUSES
        houseListViewController.title = "Houses"
        houseListViewController.tabBarItem.image = UIImage(named: "Houses")
        // Crear título e icono del UITabBar para SEASONS
        seasonListViewController.title = "Seasons"
        seasonListViewController.tabBarItem.image = UIImage(named: "Seasons")

        
        tabBarViewController.viewControllers = [houseListViewController.wrappedInNavigation(), seasonListViewController.wrappedInNavigation()]
        
        // Seleccionar por defecto al iniciar la App la primera pestaña del tabBar
        
       //tabBarViewController.tabBar.selectedItem = tabBarViewController.tabBar.items![0]
            
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Asignar los delegados
        houseListViewController.delegate = houseDetailViewController
        seasonListViewController.delegate = seasonDetailViewController
        tabBarViewController.delegate = self
        
        // Asignar controladores al tabBar
        viewControllers = [tabBarViewController, houseDetailViewController.wrappedInNavigation()]
        // mostrar las vistas
        preferredDisplayMode = .allVisible
        
    }
    
}

extension WesterosSplitViewController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // Chequear si estamos mostrando el splitView (modo iPad - landscape)
        if (isCollapsed == false) {
            // Mirar qué controlador estamos mostrando: Houses o Seasons
            if tabBarController.selectedIndex == 0 {
                self.delegate = houseListViewController
                show(houseDetailViewController.wrappedInNavigation(), sender: self)
            } else {
                self.delegate = seasonListViewController
                show(seasonDetailViewController.wrappedInNavigation(), sender: self)
            }
        }
        
    }
    
}


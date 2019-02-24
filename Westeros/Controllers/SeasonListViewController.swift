//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by Casa on 22/2/19.
//  Copyright © 2019 Miriam Sanchez. All rights reserved.
//

import UIKit

// Definir un delegado propio
protocol SeasonListViewControllerDelegate {
    func seasonListViewController(_ viewController: SeasonListViewController, didSelectSeason: Season)
}

class SeasonListViewController: UITableViewController {
    
    // MARK: Properties
    let model: [Season]
    var delegate: SeasonListViewControllerDelegate?
    
    // MARK: Inizialization
    init(model: [Season]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Westeros Seasons"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Descubri la season a mostrar
        let season = model[indexPath.row]
        
        // Crear la celda
        let cellId = "SeasonCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        // Sincronizar celda-modelo
        cell?.textLabel?.text = season.description
        cell?.imageView?.image = season.image
        
        // Devolver la celda
        return cell!
    }
    
    // MARK: UITableView Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar la Season seleccionada
        let season = model[indexPath.row]
        
        // Chequear dispositivo
        if UIApplication.shared.statusBarOrientation.isLandscape && UIDevice.current.userInterfaceIdiom != .phone {
            // Avisar al delegado
            delegate?.seasonListViewController(self, didSelectSeason: season)
        } else {
            let seasonDetailViewController = SeasonDetailViewController(model: season)
            navigationController?.pushViewController(seasonDetailViewController, animated: true)
        }
                
        
        // Emitir la misma info por notificaciones
        let notificationCenter = NotificationCenter.default
        // Creamos la notificación
        let notification = Notification(name: Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME), object: self, userInfo: [SEASON_KEY: season])
        
        // Enviamos la notificación
        notificationCenter.post(notification)
        
        // Guardar la casa seleccionada
        saveLastSelectedSeason(at: indexPath.row)
        
        
    }
}

extension SeasonListViewController {
    func saveLastSelectedSeason(at index: Int) {
        // UserDefaults será nuestro motor de persistencia
        let userDefaults = UserDefaults.standard
        
        // Escribimos el index en una key de nuestro motor de persistencia
        userDefaults.set(index, forKey: LAST_SEASON_KEY)
        
        // Guardamos
        userDefaults.synchronize() // Por si acaso (save)
    }
    
    func lastSelectedSeason() -> Season {
        // UserDefaults
        let userDefaults = UserDefaults.standard
        
        // Leemos de nuestro motor de persistencia
        let index = userDefaults.integer(forKey: LAST_SEASON_KEY) // 0 es default
        
        // Devolvemos la casa situada en el index
        return season(at: index)
    }
    
    func season(at index: Int) -> Season {
        return model[index]
    }
}

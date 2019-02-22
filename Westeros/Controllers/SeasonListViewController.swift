//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by Casa on 22/2/19.
//  Copyright © 2019 Miriam Sanchez. All rights reserved.
//

import UIKit

class SeasonListViewController: UITableViewController {
    
    // MARK: Properties
    let model: [Season]
    
    // MARK: Inizialization
    init(model: [Season]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Westeros"
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
        
        // Crear el controlador de detalle de la Season
        let seasonDetailViewController = SeasonDetailViewController(model: season)
        
        // Mostarlo (push)
        navigationController?.pushViewController(seasonDetailViewController, animated: true)
    }
}


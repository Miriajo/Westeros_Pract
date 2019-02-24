//
//  EpisodeListViewController.swift
//  Westeros
//
//  Created by Casa on 22/2/19.
//  Copyright © 2019 Miriam Sanchez. All rights reserved.
//

import UIKit

class EpisodeListViewController: UITableViewController {
  
    
    // MARK: Properties
    var model: [Episode]
    
    // MARK: Inizialization
    init(model: [Episode]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        
        title = "Episodes"
                
    }
    
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Nos damos de alta en las notificaciones
        // Tan pronto como te des de alta, implementa el código para darte de baja. Si no, te olvidarás
        let notificationCenter = NotificationCenter.default
        let name = Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME)
        
        notificationCenter.addObserver(self,
                                       selector: #selector(seasonDidChange(notification:)),
                                       name: name,
                                       object: nil) // Object es quien manda la notific
        
       syncModelWithViewList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Nos damos de baja en las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    // MARK: Notification
    @objc func seasonDidChange(notification: Notification) {
        // Sacar el userInfo de la noti, y la casa del userInfo
        guard let info = notification.userInfo,
            let season = info[SEASON_KEY] as? Season else {
                return
        }
        
        // Actualizar mi modelo
        model = season.sortedEpisodes
        
        syncModelWithViewList()
        
    }
    
    // MARK: Sync
    func syncModelWithViewList() {
      
        // Asignar el botón de vuelta
        let backButton = UIBarButtonItem(title: model[0].season!.description, style: .plain, target: self, action: Selector(("none")))
        navigationController?.navigationBar.backItem?.backBarButtonItem = backButton
        
        // Recargamos el controlador
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Descubri la season a mostrar
        let episode = model[indexPath.row]
        
        // Crear la celda
        let cellId = "SeasonCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        // Sincronizar celda-modelo
        cell?.textLabel?.text = episode.description + " - " + episode.title
        
        // Devolver la celda
        return cell!
    }
    
    // MARK: UITableView Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar la Season seleccionada
        let episode = model[indexPath.row]
        
        // Crear el controlador de detalle de la Season
        let episodeDetailViewController = EpisodeDetailViewController(model: episode)
        
        
        episodeDetailViewController.delegate = self
//        
//        // Asignar el botón de vuelta
//        let backButton = UIBarButtonItem(title: model[0].season!.description, style: .plain, target: self, action: Selector(("none")))
//        episodeDetailViewController.navigationController?.navigationBar.backItem?.backBarButtonItem = backButton
//        
//        
        // Mostarlo (push)
        navigationController?.pushViewController(episodeDetailViewController, animated: true)
    }
    
}

extension EpisodeListViewController: EpisodeDetailViewControllerDelegate {
    func episodeDetailViewController(_ viewController: EpisodeDetailViewController, season: Season) {
        self.model = season.sortedEpisodes
        syncModelWithViewList()
        viewController.delegate = self
        
    }
    
}

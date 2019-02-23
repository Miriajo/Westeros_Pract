//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by Casa on 21/2/19.
//  Copyright © 2019 Miriam Sanchez. All rights reserved.
//

import UIKit

class SeasonDetailViewController: UIViewController {

    @IBOutlet weak var seasonTitleLabel: UILabel!
    @IBOutlet weak var seasonPosterImg: UIImageView!
    @IBOutlet weak var seasonDateLabel: UILabel!
    @IBOutlet weak var seasonEpisodesLabel: UILabel!
    
    
    // MARK: Properties
    var model: Season
    
    // MARK: Inizialization
    init(model: Season) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = self.model.description
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
        
        syncModelWithView()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Nos damos de baja en las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    
    // MARK: Sync
    func syncModelWithView() {
        seasonTitleLabel.text = model.description
        
       // Indicar el formato de visualización de la fecha y convertirla a String
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "dd-MMMM-y"
        seasonDateLabel.text = "Air Date: " + displayFormatter.string(from: model.airedDate)
     
        seasonPosterImg.image = model.image
        
        
        seasonEpisodesLabel.text = model.episodesCount
        
    }
    
    // MARK: UI
    func setupUI() {
        // Crear el boton para ver los Episodes
        let episodesButton = UIBarButtonItem(title: "Episodes", style: .plain, target: self, action: #selector(displayEpisodes))
        
        // Asignar el botón de vuelta
        let backButton = UIBarButtonItem(title: model.description, style: .plain, target: self, action: Selector(("none")))
        
        // Mostrar los botones
        navigationItem.title = model.description
        navigationItem.rightBarButtonItem = episodesButton
        navigationItem.backBarButtonItem = backButton
        
    }
    
    @objc func displayEpisodes() {
        // Creamos el controlador
        let episodeListViewController = EpisodeListViewController(model: model.sortedEpisodes)
        
        // Lo mostramos mediante push
        navigationController?.pushViewController(episodeListViewController, animated: true)
    }
 
    // MARK: Notification
    @objc func seasonDidChange(notification: Notification) {
        // Sacar el userInfo de la noti, y la casa del userInfo
        guard let info = notification.userInfo,
            let season = info[SEASON_KEY] as? Season else {
                return
        }
        
        // Actualizar mi modelo
        model = season
        
        // Asignar el botón de vuelta
        let backButton = UIBarButtonItem(title: model.description, style: .plain, target: self, action: Selector(("none")))
        navigationItem.backBarButtonItem = backButton
        
        // Sincronizar modelo y vista
        syncModelWithView()
        setupUI()
    }
}

extension SeasonDetailViewController: SeasonListViewControllerDelegate {
    func seasonListViewController(_ viewController: SeasonListViewController, didSelectSeason season: Season) {
        self.model = season
        syncModelWithView()
    }
}

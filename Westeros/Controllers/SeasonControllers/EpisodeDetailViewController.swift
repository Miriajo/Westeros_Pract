//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by Casa on 22/2/19.
//  Copyright © 2019 Miriam Sanchez. All rights reserved.
//

import UIKit


// Definir un delegado propio
protocol EpisodeDetailViewControllerDelegate {
    func episodeDetailViewController(_ viewController: EpisodeDetailViewController, season: Season)
}

class EpisodeDetailViewController: UIViewController {

    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var episodeDateLabel: UILabel!
    @IBOutlet weak var episodeSummaryText: UITextView!
    
    // MARK: Properties
    var model: Episode
    var delegate: EpisodeDetailViewControllerDelegate?
    
    // MARK: Inizialization
    init(model: Episode) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = (model.season?.description)! + " - " + model.description
        
        // Asignar el delegado
        self.delegate = EpisodeListViewController(model: (model.season?.sortedEpisodes)!)
        
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
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Nos damos de baja en las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  navigationItem.backBarButtonItem?.title = "Episodes"
        
    }
    
    // MARK: Sync
    func syncModelWithView() {
        episodeTitleLabel.text = model.title
        
        // Indicar el formato de visualización de la fecha y convertirla a String
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "dd-MMMM-y"
        episodeDateLabel.text = "Air Date: " + displayFormatter.string(from: model.airedDate)
        
        episodeSummaryText.text = model.summary
        
        // Asignar el botón de vuelta
        let backButton = UIBarButtonItem(title: model.season?.description, style: .plain, target: self, action: Selector(("none")))
        navigationController?.navigationBar.backItem?.backBarButtonItem = backButton
        
    }
 
    // MARK: Notification
    @objc func seasonDidChange(notification: Notification) {
        // Sacar el userInfo de la noti, y la casa del userInfo
        guard let info = notification.userInfo,
            let season = info[SEASON_KEY] as? Season else {
                return
        }

        // Avisar al delegado
        delegate?.episodeDetailViewController(self, season: season)
        
        navigationController?.popViewController(animated: true)
    }
    
}

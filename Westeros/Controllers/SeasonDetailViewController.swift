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
        title = model.description
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncModelWithView()
        setupUI()
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
        
        // Mostrarlo
        navigationItem.rightBarButtonItem = episodesButton
    }
    
    @objc func displayEpisodes() {
        // Creamos el controlador
        let episodeListViewController = EpisodeListViewController(model: model.sortedEpisodes)
        
        // Lo mostramos mediante push
        navigationController?.pushViewController(episodeListViewController, animated: true)
    }
 
    
}

extension SeasonDetailViewController: SeasonListViewControllerDelegate {
    func seasonListViewController(_ viewController: SeasonListViewController, didSelectSeason season: Season) {
        self.model = season
        syncModelWithView()
    }
}

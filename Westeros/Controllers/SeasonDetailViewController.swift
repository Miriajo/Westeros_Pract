//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by Casa on 21/2/19.
//  Copyright © 2019 Miriam Sanchez. All rights reserved.
//

import UIKit

class SeasonDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var seasonTitleLabel: UILabel!
    @IBOutlet weak var seasonPosterImg: UIImageView!
    @IBOutlet weak var seasonDateLabel: UILabel!
    
    @IBOutlet weak var seasonEpisodeList: UITableView!
    
    // MARK: Properties
    let model: Season
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.seasonEpisodeList.dataSource = self
        self.seasonEpisodeList.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncModelWithView()
    }
    
    // MARK: Sync
    func syncModelWithView() {
        seasonTitleLabel.text = model.description
        seasonPosterImg.image = model.image
        
       // Indicar el formato de visualización de la fecha y convertirla a String
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "dd-MMMM-y"
        seasonDateLabel.text = "Live Date: \n" + displayFormatter.string(from: model.airedDate)
        
        // Mostrar la lista de episodios
//        seasonEpisodesList.dataSource = model.sortedEpisodes as? UITableViewDataSource
//        seasonEpisodesList.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Episodes"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.sortedEpisodes.count
    }
    
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Descubri la season a mostrar
        let episode = model.sortedEpisodes[indexPath.row]
        
        // Crear la celda
        let cellId = "EpisodeCell"
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
    
    
}

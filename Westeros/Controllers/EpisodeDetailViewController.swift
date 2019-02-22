//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by Casa on 22/2/19.
//  Copyright © 2019 Miriam Sanchez. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var episodeDateLabel: UILabel!
    @IBOutlet weak var episodeSummaryText: UITextView!
    
    // MARK: Properties
    let model: Episode
    
    // MARK: Inizialization
    init(model: Episode) {
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
        
    }
    
    // MARK: Sync
    func syncModelWithView() {
        episodeTitleLabel.text = model.title
        
        // Indicar el formato de visualización de la fecha y convertirla a String
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "dd-MMMM-y"
        episodeDateLabel.text = "Air Date: " + displayFormatter.string(from: model.airedDate)
        
        episodeSummaryText.text = model.summary
        
    }
    
}

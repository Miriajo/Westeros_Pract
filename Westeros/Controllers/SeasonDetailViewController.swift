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
        seasonDateLabel.text = displayFormatter.string(from: model.airedDate)
    }
    
    
    
    
}

//
//  MemberDetailViewController.swift
//  Westeros
//
//  Created by Casa on 23/2/19.
//  Copyright © 2019 Miriam Sanchez. All rights reserved.
//

import UIKit

class MemberDetailViewController: UIViewController {

    @IBOutlet weak var memberNameLabel: UILabel!
    @IBOutlet weak var memberAliasLabel: UILabel!
    @IBOutlet weak var memberImage: UIImageView!
    
    // MARK: Properties
    let model: Person
    
    // MARK: Inizialization
    init(model: Person) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = self.model.fullName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        syncModelWithView()
    }

    // MARK: Sync
    func syncModelWithView() {
        memberNameLabel.text = model.fullName
        memberAliasLabel.text = model.alias
        memberImage.image = model.image
    }
    

}

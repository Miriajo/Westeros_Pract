//
//  HouseDetailViewController.swift
//  Westeros
//
//  Created by Alexandre Freire on 04/02/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import UIKit

class HouseDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var wordsLabel: UILabel!
    
    // MARK: Properties
    var model: House
    
    // MARK: Initialization
    init(model: House) {
        // Primero, limpio mi mierda
        self.model = model
        // Llamo a super
        super.init(nibName: nil, bundle: nil)
        title = model.name
    }
    
    // Chapuza de los de Cupertino relacionada con el miedo a nil
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
        title = model.name
        houseNameLabel.text = "House \(model.name)"
        sigilImageView.image = model.sigil.image
        wordsLabel.text = model.words
    }
    
    // MARK: UI
    func setupUI() {
        // Crear los botones
        let wikiButton = UIBarButtonItem(title: "Wiki", style: .plain, target: self, action: #selector(displayWiki))
        
        let membersButton = UIBarButtonItem(title: "Members", style: .plain, target: self, action: #selector(displayMembers))
        
        // Mostrar los botones
        navigationItem.rightBarButtonItems = [membersButton, wikiButton]
    }
    
    @objc func displayMembers() {
        // Creamos el controlador
        let memberListViewController = MemberListViewController(model: model.sortedMembers)
        
        // Lo mostramos mediante push
        navigationController?.pushViewController(memberListViewController, animated: true)
    }
    
    @objc func displayWiki() {
        // Creamos el controlador
        let wikiViewController = WikiViewController(model: model)
        
        // Hacemos push
        navigationController?.pushViewController(wikiViewController, animated: true)
    }
}

extension HouseDetailViewController: HouseListViewControllerDelegate {
    func houseListViewController(_ viewController: HouseListViewController, didSelectHouse house: House) {
        // Re-asigna el modelo
        self.model = house
        
        // Sincroniza modelo (el nuevo) con la vista
        syncModelWithView()
    }
}

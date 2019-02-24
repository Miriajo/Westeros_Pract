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
        title = self.model.house.name + " House" //self.model.fullName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backBarButtonItem?.title = "Members"
        
        syncModelWithView()
    }

    // MARK: Sync
    func syncModelWithView() {
        memberNameLabel.text = model.fullName
        memberAliasLabel.text = model.alias
        memberImage.image = model.image
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Nos damos de alta en las notificaciones
        // Tan pronto como te des de alta, implementa el código para darte de baja. Si no, te olvidarás
        let notificationCenter = NotificationCenter.default
        let name = Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME)
        
        notificationCenter.addObserver(self,
                                       selector: #selector(houseDidChange(notification:)),
                                       name: name,
                                       object: nil) // Object es quien manda la notific
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Nos damos de baja en las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    
    // MARK: Notification
    @objc func houseDidChange(notification: Notification) {
//        // Sacar el userInfo de la noti, y la casa del userInfo
//        guard let info = notification.userInfo,
//            let house = info[HOUSE_KEY] as? House else {
//                return
//        }
//        
//        // Actualizar mi modelo
//        model = house.sortedMembers
//        
//        // Asignar el botón de vuelta
//        let backButton = UIBarButtonItem(title: house.name, style: .plain, target: self, action: Selector(("none")))
//        navigationItem.backBarButtonItem = backButton
//        
//        // Actualizar vista recargando el controlador
//        tableView.reloadData()
        
        navigationController?.popViewController(animated: true)
    }
    
}

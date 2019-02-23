//
//  MemberListViewController.swift
//  Westeros
//
//  Created by Alexandre Freire on 07/02/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//
import UIKit

class MemberListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var model: [Person]
    
    // MARK: Initialization
    init(model: [Person]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Members"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Error tipiquísimo
        // Te va a seguir ocurriendo tengas 10 días de experiencia o 10 años
        tableView.dataSource = self
        tableView.delegate = self
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
        // Sacar el userInfo de la noti, y la casa del userInfo
        guard let info = notification.userInfo,
            let house = info[HOUSE_KEY] as? House else {
                return
        }
        
        // Actualizar mi modelo
        model = house.sortedMembers
        
        // Asignar el botón de vuelta
        let backButton = UIBarButtonItem(title: house.name, style: .plain, target: self, action: Selector(("none")))
        navigationItem.backBarButtonItem = backButton
        
        // Actualizar vista recargando el controlador
        tableView.reloadData()
    }
}

extension MemberListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Descubrir la persona
        let person = model[indexPath.row]
        
        // Pedir una celda a la tabla (si es que la tiene), o si no, crearla.
        let cellId = "MemberCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        
        // Sincronizar modelo y vista
        cell?.textLabel?.text = person.fullName
        cell?.detailTextLabel?.text = person.alias
        
        // Devolver la celda
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar la Season seleccionada
        let member = model[indexPath.row]
        
        // Crear el controlador de detalle de la Season
        let memberDetailViewController = MemberDetailViewController(model: member)
        
        // Asignar boton back
        let backButton = UIBarButtonItem(title: "\(member.house)", style: .plain, target: self, action: Selector(("none")))
        
        navigationController?.navigationItem.backBarButtonItem = backButton
        
        // Mostarlo (push)
        navigationController?.pushViewController(memberDetailViewController, animated: true)
    }
}


extension MemberListViewController: UITableViewDelegate {
    
}

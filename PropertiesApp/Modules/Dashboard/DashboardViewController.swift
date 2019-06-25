//
//  DashboardViewController.swift
//  PropertiesApp
//
//  Created by Apit Gilang Aprida on 25/06/19.
//  Copyright © 2019 Apit Gilang Aprida. All rights reserved.
//

import Foundation
import UIKit

// MARK: - SegueConstants

extension SegueConstants {
    enum Dashboard {
        // TODO: Add segue ids
    }
}

// MARK: -  DashboardViewController

class DashboardViewController: ViewController {
    
    @IBOutlet weak var tableViewProperties: UITableView!
    var screenName: String? { get { return "Dashboard" } }
    
    // MARK: Properties
    
    var presenter: DashboardPresenter!
    var properties: [PropertyTypes] = []
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DashboardPresenter.config(withDashboardViewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewProperties.delegate = self
        tableViewProperties.dataSource = self
        tableViewProperties.register(UITableViewCell.self, forCellReuseIdentifier: "propertyCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter.getProperties()
    }
    
    @IBAction func onButtonAddPropertyPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Add Property", message: "Tambahkan nama property", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Nama property"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0]
            self.presenter.addProperty(withName: textField.text ?? "")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return properties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "propertyCell", for: indexPath)
        let property = properties[indexPath.row]
        cell.textLabel?.text = property.name
        return cell
    }
}

// MARK: - DashboardView

extension DashboardViewController: DashboardView {
    func displayProperty(withProperties properties: [PropertyTypes]) {
        self.properties = properties
        tableViewProperties.reloadData()
    }
    
    func reloadProperties() {
        self.presenter.getProperties()
    }
    
    func showAlert(withMessage message: String) {
        showWarning(withMessage: message)
    }
}

//
//  LoginViewController.swift
//  PropertiesApp
//
//  Created by Apit Gilang Aprida on 25/06/19.
//  Copyright © 2019 Apit Gilang Aprida. All rights reserved.
//

import Foundation
import UIKit

// MARK: - SegueConstants

extension SegueConstants {
    enum Login {
        static let goToDashboard = "goToDashboard"
    }
}

// MARK: -  LoginViewController

class LoginViewController: ViewController {
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    var screenName: String? { get { return "Login" } }
    
    // MARK: Properties
    
    var presenter: LoginPresenter!
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        LoginPresenter.config(withLoginViewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if SegueConstants.Login.goToDashboard == segue.identifier {
            if let nav = segue.destination as? UINavigationController {
                if let vc = nav.viewControllers.first as? DashboardViewController {
                }
            }
        }
    }
    
    @IBAction func onButtonLoginPressed(_ sender: Any) {
        presenter.login(withEmail: textFieldEmail.text ?? "", withPassword: textFieldPassword.text ?? "")
    }
}

// MARK: - LoginView

extension LoginViewController: LoginView {
    func goToHome() {
        performSegue(withIdentifier: SegueConstants.Login.goToDashboard, sender: nil)
    }
    
    func showAlert(withMessage message: String) {
        showWarning(withMessage: message)
    }
}

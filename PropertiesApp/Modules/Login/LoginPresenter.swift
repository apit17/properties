//
//  LoginPresenter.swift
//  PropertiesApp
//
//  Created by Apit Gilang Aprida on 25/06/19.
//  Copyright © 2019 Apit Gilang Aprida. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol LoginViewPresenter: class {
    init(view: LoginView)
    func login(withEmail email: String, withPassword password: String)
}

protocol LoginView: class {
    func goToHome()
    func showAlert(withMessage message: String)
}

class LoginPresenter: LoginViewPresenter {
    
    static func config(withLoginViewController vc: LoginViewController) {
        let presenter = LoginPresenter(view: vc)
        vc.presenter = presenter
    }
    
    let view: LoginView
    
    required init(view: LoginView) {
        self.view = view
    }
    
    func login(withEmail email: String, withPassword password: String) {
        let request = LoginRequestParamApi()
        request.email = email
        request.password = password
        Api.instance.request(ApiLogin.loginRequest(request: request), success: { (json) in
            guard let json = json else {
                return
            }
            UserDefaults.standard.set(json["token"].stringValue, forKey: "token")
            print(json["token"].stringValue)
            self.view.goToHome()
        }) { (message) in
            self.view.showAlert(withMessage: message)
        }
    }
}

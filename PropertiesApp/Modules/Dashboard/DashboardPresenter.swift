//
//  DashboardPresenter.swift
//  PropertiesApp
//
//  Created by Apit Gilang Aprida on 25/06/19.
//  Copyright © 2019 Apit Gilang Aprida. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol DashboardViewPresenter: class {
    init(view: DashboardView)
    func getProperties()
    func addProperty(withName name: String)
}

protocol DashboardView: class {
    func displayProperty(withProperties properties: [PropertyTypes])
    func reloadProperties()
    func showAlert(withMessage message: String)
}

class DashboardPresenter: DashboardViewPresenter {
    
    static func config(withDashboardViewController vc: DashboardViewController) {
        let presenter = DashboardPresenter(view: vc)
        vc.presenter = presenter
    }
    
    let view: DashboardView
    
    required init(view: DashboardView) {
        self.view = view
    }
    
    func getProperties() {
        Api.instance.request(ApiDashboard.getProperties(), success: { (json) in
            guard let json = json else {
                return
            }
            var properties = [PropertyTypes]()
            for data in json.arrayValue {
                properties.append(PropertyTypes(json: data))
            }
            self.view.displayProperty(withProperties: properties)
        }) { (message) in
            print(message)
        }
    }
    
    func addProperty(withName name: String) {
        Api.instance.request(ApiDashboard.addProperty(name: name), success: { (json) in
            self.view.reloadProperties()
        }) { (message) in
            self.view.showAlert(withMessage: message)
        }
    }
}

//
//  LoginRequestParamApi.swift
//  PropertiesApp
//
//  Created by Apit Gilang Aprida on 25/06/19.
//  Copyright © 2019 Apit Gilang Aprida. All rights reserved.
//

import Foundation

class LoginRequestParamApi {
    
    var email: String?
    var password: String?
    
    func buildForParameters() -> [String: AnyObject] {
        var parameters: [String: AnyObject] = [:]
        parameters["email"] = email as AnyObject
        parameters["password"] = password as AnyObject
        return parameters
    }
}

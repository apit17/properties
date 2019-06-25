//
//  ApiDashboard.swift
//  PropertiesApp
//
//  Created by Apit Gilang Aprida on 25/06/19.
//  Copyright © 2019 Apit Gilang Aprida. All rights reserved.
//

import Foundation
import Alamofire

enum ApiDashboard: URLRequestConvertible {
    
    case getProperties()
    case addProperty(name: String)
    
    var path: String {
        switch self {
        case .getProperties(), .addProperty(_):
            return "property-types"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getProperties():
            return .get
        case .addProperty(_):
            return .post
        }
    }
    
    var parameter: [String: AnyObject] {
        switch self {
        case .getProperties():
            return [:]
        case .addProperty(let name):
            return ["name": name as AnyObject]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try ApiConstants.BASE_URL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(self.path))
        urlRequest.httpMethod = method.rawValue
        let token = UserDefaults.standard.string(forKey: "token")
        if let token = token {
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        return try JSONEncoding.default.encode(urlRequest, with: self.parameter)
    }
}

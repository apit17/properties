//
//  ApiLogin.swift
//  PropertiesApp
//
//  Created by Apit Gilang Aprida on 25/06/19.
//  Copyright © 2019 Apit Gilang Aprida. All rights reserved.
//

import Foundation
import Alamofire

enum ApiLogin: URLRequestConvertible {
    
    case loginRequest(request: LoginRequestParamApi)
    
    var path: String {
        switch self {
        case .loginRequest(_):
            return "login"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .loginRequest(_):
            return .post
        }
    }
    
    var parameter: [String: AnyObject] {
        switch self {
        case .loginRequest(let request):
            return request.buildForParameters()
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try ApiConstants.BASE_URL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(self.path))
        urlRequest.httpMethod = method.rawValue
        return try JSONEncoding.default.encode(urlRequest, with: self.parameter)
    }
}

//
//  Api.swift
//  PropertiesApp
//
//  Created by Apit Gilang Aprida on 25/06/19.
//  Copyright © 2019 Apit Gilang Aprida. All rights reserved.
//

import Foundation

import Foundation
import Alamofire
import SwiftyJSON
import Reachability

typealias SuccessResponse = (JSON?) -> Void
typealias ErrorResponse = (String) -> Void

class Api {
    
    static let instance = Api()
    
    var alamofireManager: SessionManager = SessionManager.default
    var req: Request?
    
    init() {
        self.setAFconfig()
    }
    
    func setAFconfig() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30 // seconds
        configuration.timeoutIntervalForResource = 30
        self.alamofireManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func request(_ request: URLRequestConvertible, success:@escaping SuccessResponse, error:@escaping ErrorResponse) {
        req = alamofireManager.request(request).responseJSON { response in
            
            let statusCode = response.response?.statusCode ?? 500
            if response.result.isFailure || 500 == response.response?.statusCode {
                if let reachability = Reachability(), reachability.connection == .none {
                    error(Response.MESSAGE_NOT_CONNECTED_INTERNET)
                } else {
                    error(Response.MESSAGE_SYSTEM_ERROR)
                }
            } else if let value = response.result.value {
                let jsonValue = JSON(value)
                let baseApi = BaseApiDAO(json: jsonValue)
                if baseApi.isCodeFailed() || baseApi.isNotContainsStringSuccess() || statusCode >= 300{
                    let message = baseApi.getMessage()
                    if message.isEmptyAfterTrim {
                        error(Response.MESSAGE_SYSTEM_ERROR)
                    } else {
                        error(message)
                    }
                } else {
                    success(jsonValue)
                }
            } else {
                error(Response.MESSAGE_SYSTEM_ERROR)
            }
            
            self.invalidateAndConfigure()
        }
    }
    
    func uploadImage(_ request: URLRequestConvertible, multipartFormData: @escaping (MultipartFormData) -> Void, success: @escaping SuccessResponse, error:@escaping ErrorResponse) {
        alamofireManager.upload(multipartFormData: multipartFormData, with: request) { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON {
                    response in
                    if response.result.error == nil {
                        let json = JSON(response.result.value!)
                        print(json)
                        success(json)
                    } else {
                        error(Response.MESSAGE_NOT_CONNECTED_INTERNET)
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
                error(Response.MESSAGE_NOT_CONNECTED_INTERNET)
            }
            self.invalidateAndConfigure()
        }
    }
    
    func invalidateAndConfigure() {
        self.alamofireManager.session.finishTasksAndInvalidate()
        self.setAFconfig()
    }
    
    class Response {
        static let MESSAGE_SYSTEM_ERROR = "Maaf, terjadi kesalahan sistem"
        static let MESSAGE_INTERNAL_SERVER_ERROR = "Terjadi Kesalahan Server"
        static let MESSAGE_NOT_CONNECTED_INTERNET = "Tidak Ada Koneksi Internet"
        
        static func shouldHiddenWarningImage(withMessage message: String?) -> Bool {
            return MESSAGE_INTERNAL_SERVER_ERROR == message || MESSAGE_NOT_CONNECTED_INTERNET == message
        }
        
        static func isMessageError(withMessage message: String?) -> Bool {
            return MESSAGE_SYSTEM_ERROR == message
        }
        
        static func isMessageNotConnectedInternet(withMessage message: String?) -> Bool {
            return MESSAGE_NOT_CONNECTED_INTERNET == message
        }
    }
}

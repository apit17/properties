//
//  SummaryDAO.swift
//  PropertiesApp
//
//  Created by Apit Gilang Aprida on 25/06/19.
//  Copyright © 2019 Apit Gilang Aprida. All rights reserved.
//

import Foundation
import SwiftyJSON

open class SummaryDAO {
    
    enum Code {
        static let failed = "failed"
        static let success = "success"
        static let requestSuccess = "request_success"
        static let emailUnverified = "email_unverified"
        static let logisticLocation = "logistics.invalid.sku.location"
    }
    
    // Static members
    
    static internal let kCodeKey: String = "code"
    static internal let kFieldsKey: String = "fields"
    static internal let kMessageKey: String = "message"
    
    // Data members
    
    internal var code: String?
    internal var fields: String?
    internal var message: String?
    
    // Constructors
    
    public init() {}
    
    public init(json: JSON?) {
        
        if let json = json {
            code = json[SummaryDAO.kCodeKey].string
            fields = json[SummaryDAO.kFieldsKey].string
            message = json[SummaryDAO.kMessageKey].string
        }
    }
    
    // Methods
    
    func isCodeSuccess() -> Bool {
        return Code.success == code || Code.requestSuccess == code
    }
    
    func isCodeFailed() -> Bool {
        return Code.failed == code
    }
    
    func isEmailUnverified() -> Bool {
        return Code.emailUnverified == code
    }
    
    func islogisticLocation() -> Bool {
        return Code.logisticLocation == code
    }
    
    func hasMessage() -> Bool {
        if let msg = message {
            return !msg.isEmpty
        }
        
        return false
    }
    
    func getMessage() -> String {
        return message ?? ""
    }
    
    func getCode() -> String {
        return code ?? ""
    }
}

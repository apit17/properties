//
//  BaseApiDAO.swift
//  PropertiesApp
//
//  Created by Apit Gilang Aprida on 25/06/19.
//  Copyright © 2019 Apit Gilang Aprida. All rights reserved.
//

import Foundation
import SwiftyJSON

open class BaseApiDAO: SummaryDAO {
    
    // Static members
    
    static internal let kSummaryKey: String = "summary"
    
    // Data members
    
    var summary: SummaryDAO?
    var jsonSummaryString: String?
    
    // Constructors
    
    override init(json: JSON?) {
        
        super.init(json: json)
        if let json = json {
            summary = SummaryDAO(json: json[BaseApiDAO.kSummaryKey])
            jsonSummaryString = json[BaseApiDAO.kSummaryKey].string
        }
    }
    
    // Methods
    
    func hasSummary() -> Bool {
        
        return summary != nil
    }
    
    func getSummary() -> SummaryDAO {
        
        if let dao = summary {
            return dao
        }
        let emptyDAO: SummaryDAO = SummaryDAO()
        summary = emptyDAO
        return emptyDAO
    }
    
    override func isCodeFailed() -> Bool {
        return "failed" == getCode()
    }
    
    override func getCode() -> String {
        if let summaryCode = summary?.code {
            return summaryCode
        }
        return code ?? ""
    }
    
    override func getMessage() -> String {
        if let summaryMessage = summary?.message {
            return summaryMessage
        }
        return message ?? ""
    }
    
    override func hasMessage() -> Bool {
        return !getMessage().isEmptyAfterTrim
    }
    
    func isNotContainsStringSuccess() -> Bool {
        if let jsonSummaryString = jsonSummaryString {
            return !jsonSummaryString.lowercased().contains("success")
        }
        return false
    }
    
    func isCodeNeedOtpVerification() -> Bool {
        return getCode() == "NEED_OTP_VERIFICATION"
    }
}

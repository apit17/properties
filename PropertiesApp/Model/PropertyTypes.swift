//
//  PropertyTypes.swift
//  PropertiesApp
//
//  Created by Apit Gilang Aprida on 25/06/19.
//  Copyright © 2019 Apit Gilang Aprida. All rights reserved.
//

import Foundation
import SwiftyJSON

class PropertyTypes {
    
    var id: Int?
    var name: String?
    
    init(json: JSON?) {
        guard let json = json else {
            return
        }
        id = json["id"].int
        name = json["name"].string
    }
}

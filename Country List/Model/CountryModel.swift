//
//  CountryModel.swift
//  Country List
//
//  Created by rahman fad on 12/05/18.
//  Copyright © 2018 rahman fad. All rights reserved.
//

import Foundation
 
struct CountryModel {
    let id: Int64?
    var name: String
    var code: String
    
    init(id: Int64) {
        self.id = id
        name = ""
        code = ""
    }

    init(id: Int64, name: String, code: String) {
        self.id = id
        self.name = name
        self.code = code
    }
}

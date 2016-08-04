//
//  Rower.swift
//  Coach Assist
//
//  Created by Pavel Asparouhov on 8/4/16.
//  Copyright © 2016 BigP inc. All rights reserved.
//

import UIKit

class Rower {
    var name: String
    var weight: String
    init?(name: String, weight: Int){
        self.name = name
        self.weight = String(weight)
        if name.isEmpty{
            return nil
        }
    }
}
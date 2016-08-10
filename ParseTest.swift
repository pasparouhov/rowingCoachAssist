//
//  ParseTest.swift
//  Coach Assist
//
//  Created by Pavel Asparouhov on 8/9/16.
//  Copyright © 2016 BigP inc. All rights reserved.
//

import Foundation
import Parse
class Rower : PFObject, PFSubclassing {
    
    // 2
    @NSManaged var coachName: PFUser?
    @NSManaged var k2: String?
    @NSManaged var k5: String?
    @NSManaged var k6: String?
    @NSManaged var k10: String?
    @NSManaged var customLength1: String?
    @NSManaged var customLength2: String?
    @NSManaged var customData1: String?
    @NSManaged var customData2: String?
    @NSManaged var rowerName: String?
    @NSManaged var weight: String?
    

    var k2String = ""
    var k5String = ""
    var k6String = ""
    var k10String = ""
    var customLength1String = ""
    var customLength2String = ""
    var customData1String = ""
    var customData2String = ""
    var rowerNameString = ""
    var weightString = ""
    
    
    
    //MARK: PFSubclassing Protocol
    
    // 3
    static func parseClassName() -> String {
        return "Rower"
    }
    
    // 4
    override init () {
        super.init()
    }
    
    /*override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
        }
    }*/
    func updateRower(){
        self.k6 = k6String
        self.k2 = k2String
        self.k5 = k5String
        self.k10 = k10String
        self.customData1 = customData1String
        self.customData2 = customData2String
        self.customLength1 = customLength1String
        self.customLength2 = customLength2String
        self.rowerName = rowerNameString
        self.weight = weightString
        
        
        coachName = PFUser.currentUser()
        saveInBackground()
    }
}
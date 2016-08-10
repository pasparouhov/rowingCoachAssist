//
//  InviteToTeam.swift
//  Coach Assist
//
//  Created by Pavel Asparouhov on 8/10/16.
//  Copyright © 2016 BigP inc. All rights reserved.
//

import Foundation
import Parse
class InviteToTeam : PFObject, PFSubclassing {
    
    @NSManaged var fromUser: PFUser?
    @NSManaged var toUser: PFUser?

    
    
    
    static func parseClassName() -> String {
        return "InviteToTeam"
    }
    
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
    
}

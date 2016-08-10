//
//  Practice.swift
//  Coach Assist
//
//  Created by Pavel Asparouhov on 8/10/16.
//  Copyright © 2016 BigP inc. All rights reserved.
//

import Foundation
import Parse
class Practice : PFObject, PFSubclassing {
    
    @NSManaged var coachName: PFUser?
    @NSManaged var location: String?
    @NSManaged var practiceDate: NSDate?
    @NSManaged var time: String?
    @NSManaged var distance: String?
    @NSManaged var workoutMinute: NSNumber?
    @NSManaged var workoutSeconds: NSNumber?
    @NSManaged var restMinutes: NSNumber?
    @NSManaged var restSeconds: NSNumber?
    @NSManaged var intervals: NSNumber?
    
    
    
    
    static func parseClassName() -> String {
        return "Practice"
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

//
//  RealmHelper.swift
//  Coach Assist
//
//  Created by Pavel Asparouhov on 8/4/16.
//  Copyright © 2016 BigP inc. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
    static func addRower(rower: Rower) {
        let realm = try! Realm()
        try! realm.write() {
            realm.add(rower)
        }
    }
    static func deleteRower(note: Rower) {
        let realm = try! Realm()
        try! realm.write() {
            realm.delete(note)
        }
    }
    static func retrieveRower() -> Results<Rower> {
        let realm = try! Realm()
        return realm.objects(Rower).sorted("name", ascending: true)
    }
    static func updateRower(rowerToBeUpdated: Rower, newRower: Rower) {
        let realm = try! Realm()
        try! realm.write() {
            rowerToBeUpdated.name = newRower.name
            rowerToBeUpdated.weight = newRower.weight
            rowerToBeUpdated.k2 = newRower.k2
            rowerToBeUpdated.k5 = newRower.k5
            rowerToBeUpdated.k6 = newRower.k6
            rowerToBeUpdated.k10 = newRower.k10
            rowerToBeUpdated.customLength1 = newRower.customLength1
            rowerToBeUpdated.customLength2 = newRower.customLength2
            rowerToBeUpdated.customData1 = newRower.customData1
            rowerToBeUpdated.customData2 = newRower.customData2
        }
    }

}

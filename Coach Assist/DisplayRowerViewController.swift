//
//  DisplayRowerViewController.swift
//  Coach Assist
//
//  Created by Pavel Asparouhov on 8/4/16.
//  Copyright © 2016 BigP inc. All rights reserved.
//

import UIKit
import RealmSwift
class DisplayRowerViewController: UIViewController {

    @IBOutlet weak var customData2: UITextField!
    @IBOutlet weak var customData1: UITextField!
    @IBOutlet weak var customLength2: UITextField!
    @IBOutlet weak var customLength1: UITextField!
    @IBOutlet weak var k10TextField: UITextField!
    @IBOutlet weak var k6TextField: UITextField!
    @IBOutlet weak var k5TextField: UITextField!
    @IBOutlet weak var k2TextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    var rower: Rower?
    override func viewDidLoad(){
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DisplayRowerViewController.dismissKeyboard))
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let rowerTableViewController = segue.destinationViewController as! RowerTableViewController
        if segue.identifier == "Save" {
            // if note exists, update title and content
            if let rower = rower {
                
                // 1
                let newRower = Rower()
                newRower.name = nameTextField.text ?? ""
                newRower.weight = weightTextField.text ?? ""
                newRower.k2 = k2TextField.text ?? ""
                newRower.k5 = k5TextField.text ?? ""
                newRower.k6 = k6TextField.text ?? ""
                newRower.k10 = k10TextField.text ?? ""
                newRower.customLength1 = customLength1.text ?? ""
                newRower.customLength2 = customLength2.text ?? ""
                newRower.customData1 = customData1.text ?? ""
                newRower.customData2 = customData2.text ?? ""
                
                RealmHelper.updateRower(rower, newRower: newRower)
            } else {
                // if note does not exist, create new note
                let rower = Rower()
                rower.name = nameTextField.text ?? ""
                rower.weight = weightTextField.text ?? ""
                rower.k2 = k2TextField.text ?? ""
                rower.k5 = k5TextField.text ?? ""
                rower.k6 = k6TextField.text ?? ""
                rower.k10 = k10TextField.text ?? ""
                rower.customLength1 = customLength1.text ?? ""
                rower.customLength2 = customLength2.text ?? ""
                rower.customData1 = customData1.text ?? ""
                rower.customData2 = customData2.text ?? ""
                // 2
                if rower.name != ""{
                    RealmHelper.addRower(rower)
                }
            }
            // 3
            rowerTableViewController.rowers = RealmHelper.retrieveRower()
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // 1
        if let rower = rower{
            nameTextField.text = rower.name
            weightTextField.text = rower.weight
            k2TextField.text = rower.k2
            k5TextField.text = rower.k5
            k6TextField.text = rower.k6
            k10TextField.text = rower.k10
            customLength1.text = rower.customLength1
            customLength2.text = rower.customLength2
            customData1.text = rower.customData1
            customData2.text = rower.customData2
            
        } else {
            nameTextField.text = ""
            weightTextField.text = ""
            k2TextField.text = ""
            k5TextField.text = ""
            k6TextField.text = ""
            k10TextField.text = ""
            customLength1.text = ""
            customLength2.text = ""
            customData1.text = ""
            customData2.text = ""
        }
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

}

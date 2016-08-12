//
//  DisplayCoachPracticeViewController.swift
//  Coach Assist
//
//  Created by Pavel Asparouhov on 8/10/16.
//  Copyright © 2016 BigP inc. All rights reserved.
//

import UIKit
import Parse
class DisplayCoachPracticeViewController: UIViewController {
    @IBOutlet weak var intervals: UITextField!
    @IBOutlet weak var restSec: UITextField!
    @IBOutlet weak var restMin: UITextField!
    @IBOutlet weak var workoutSec: UITextField!
    @IBOutlet weak var workoutTime: UITextField!
    @IBOutlet weak var timeOrDistance: UISegmentedControl!
    @IBOutlet weak var practiceLocation: UITextField!
    @IBOutlet weak var practiceDate: UIDatePicker!
    var practice: Practice?
    override func viewDidLoad() {
        super.viewDidLoad()
         let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DisplayCoachPracticeViewController.dismissKeyboard))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveWorkout(sender: AnyObject) {
        if let practice = practice {
            let followingQuery = PFQuery(className: "Practice")
            followingQuery.whereKey("practiceDate", equalTo:practice.practiceDate!)
            followingQuery.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) in
            let updatePractice = results!.first as! Practice
            updatePractice.practiceDate = self.practiceDate.date
            updatePractice.location = self.practiceLocation.text
            switch self.timeOrDistance.selectedSegmentIndex {
                case 0:
                    updatePractice.setObject(false, forKey: "timeOrDistance")
                case 1:
                    updatePractice.setObject(true, forKey: "timeOrDistance")
                default:
                    break
            }
            if let workoutTime = self.workoutTime.text{
                updatePractice.workoutMinute = workoutTime
            }
            if let workoutSec = self.workoutSec.text{
                updatePractice.workoutSeconds = workoutSec
            }
            if let restMin = self.restMin.text {
                    updatePractice.restMinutes = restMin
            }
            if let restSec = self.restSec.text {
                    updatePractice.restSeconds = restSec
            }
            if let intervals = self.intervals.text {
                    updatePractice.intervals = intervals
            }
            updatePractice.saveInBackground()
            }

        } else {
            let updatePractice = Practice()
            updatePractice.practiceDate = self.practiceDate.date
            updatePractice.location = self.practiceLocation.text
            switch self.timeOrDistance.selectedSegmentIndex {
            case 0:
                updatePractice.setObject(false, forKey: "timeOrDistance")
            case 1:
                updatePractice.setObject(true, forKey: "timeOrDistance")
            default:
                break
            }
            if let workoutTime = self.workoutTime.text{
                updatePractice.workoutMinute = workoutTime
            }
            if let workoutSec = self.workoutSec.text{
                updatePractice.workoutSeconds = workoutSec
            }
            if let restMin = self.restMin.text {
                updatePractice.restMinutes = restMin
            }
            if let restSec = self.restSec.text {
                updatePractice.restSeconds = restSec
            }
            if let intervals = self.intervals.text {
                updatePractice.intervals = intervals
            }
            updatePractice.coachName = PFUser.currentUser()
            updatePractice.saveInBackground()

        }
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let practice = practice {
            practiceDate.date = practice.practiceDate!
            practiceLocation.text = practice.location
            let distanceOrTime = practice["timeOrDistance"] as! Bool
            if distanceOrTime {
                self.timeOrDistance.selectedSegmentIndex = 1
            } else {
                self.timeOrDistance.selectedSegmentIndex = 0
            }
            if let placeHolder = practice.workoutMinute{
                self.workoutTime.text = String(placeHolder)
            } else {
                self.workoutTime.text = ""
            }
            if let placeHolder = practice.workoutSeconds{
//                print(placeHolder)
                self.workoutSec.text = String(placeHolder)
            } else {
                self.workoutSec.text = ""
            }
            if let placeHolder = practice.restSeconds{
                self.restSec.text = String(placeHolder)
            } else {
                self.restSec.text = ""
            }
            if let placeHolder = practice.restMinutes{
                self.restMin.text = String(placeHolder)
            } else {
                self.restMin.text = ""
            }
            if let placeHolder = practice.intervals{
                self.intervals.text = String(placeHolder)
            } else {
                self.intervals.text = ""
            }
        } else {
            workoutTime.text = ""
            workoutSec.text = ""
            restSec.text = ""
            restMin.text = ""
            intervals.text = ""
            practiceLocation.text = ""

        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  FirstViewController.swift
//  Coach Assist
//
//  Created by Pavel Asparouhov on 8/2/16.
//  Copyright © 2016 BigP inc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FirstViewController: UIViewController {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var practiceTime: UIDatePicker!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    let prefs = NSUserDefaults.standardUserDefaults()
   
    @IBOutlet weak var realPracticeLabel: UIButton!
    @IBOutlet weak var practiceTimeLabel: UILabel!

    @IBOutlet weak var enterButton: UIImageView!

    @IBOutlet weak var editLocation: UIButton!
    @IBOutlet weak var zipCodeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        label1.hidden = true
        label2.hidden = true
        label3.hidden = true
        label4.hidden = true
        weatherImage.hidden = true
        editLocation.hidden = true
        realPracticeLabel.layer.cornerRadius = 5
        if let _ = prefs.stringForKey("zipcode"){
            zipCode.hidden = true
            practiceTime.hidden = true
            zipCodeLabel.hidden = true
            practiceTimeLabel.hidden = true
            realPracticeLabel.hidden = true
            editLocation.hidden = false
            
        }
        
        if let zip = prefs.stringForKey("zipcode"){
            let hour = prefs.stringForKey("hour")!
            if Int(hour) >= 12{
                if Int(hour) != 12 {
                    label1.text = ("Weather at \(zip) at \(Int(hour)!-12) PM")
                } else {
                    label1.text = ("Weather at \(zip) at 12 PM")
                }
            } else {
                if Int(hour) != 0{
                    label1.text = ("Weather at \(zip) at \(hour) AM")
                } else {
                    label1.text = ("Weather at \(zip) at 12 AM")
                }
            }
            let apiToContact = "http://api.wunderground.com/api/74d10740555b11f4/hourly/q/\(zip).json"
            Alamofire.request(.GET, apiToContact).validate().responseJSON() { response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
//                        let currentDate = NSDate()
//                        let currentCalendar = NSCalendar.currentCalendar()
//                        let currentComponents = currentCalendar.components([NSCalendarUnit.Hour, NSCalendarUnit.Minute], fromDate: currentDate)
//                        let currentHour = currentComponents.hour
//                        print(currentHour)
                        let json = JSON(value)
                        if json["hourly_forecast"][0]["FCTTIME"]["hour"] != nil{
                            let stringURL = String(json["hourly_forecast"][0]["FCTTIME"]["hour"])
                            let weatherHour = Int(stringURL)
                            var arrayNumber = Int(hour)! - weatherHour!
                            if arrayNumber < 0{
                                arrayNumber = 0
                            }
                            let weatherData = json["hourly_forecast"][arrayNumber]
                            self.label2.text = String("\(weatherData["temp"]["english"]) Degrees Fahrenheit")
                            self.label3.text = String("\(weatherData["condition"])")
                            self.label4.text = String("Wind Speed: \(weatherData["wspd"]["english"]) MPH")
                            switch String(weatherData["fctcode"]){
                            case "1", "7":
                                self.weatherImage.image = UIImage(named: "sun")
                            case "2", "3":
                                self.weatherImage.image = UIImage(named: "partly")
                            case "4", "5", "6":
                                self.weatherImage.image = UIImage(named: "cloudy")
                            case "8", "9", "16", "18", "19", "20", "21", "22", "23", "24":
                                self.weatherImage.image = UIImage(named: "snow")
                            case "10", "11", "12", "13":
                                self.weatherImage.image = UIImage(named: "rain")
                            case "14", "15":
                                self.weatherImage.image = UIImage(named: "lightning")
                            default:
                                break
                            }
                        } else {
                            self.zipCode.hidden = false
                            self.practiceTime.hidden = false
                            self.zipCodeLabel.hidden = false
                            self.practiceTimeLabel.hidden = false
                            self.realPracticeLabel.hidden = false
                            self.editLocation.hidden = true
                            self.label1.hidden = true
                            self.label2.hidden = true
                            self.label3.hidden = true
                            self.label4.hidden = true
                            self.weatherImage.hidden = true
                            self.editLocation.hidden = true
                            let alertController = UIAlertController(title: "Invalid Zip", message:
                                "Please enter valid zip", preferredStyle: UIAlertControllerStyle.Alert)
                            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                            
                            self.presentViewController(alertController, animated: true, completion: nil)
                            self.zipCode.text = self.prefs.stringForKey("zipcode")

                        }
                    }
                case .Failure(let error):
                    print(error)
                }
            }
            
            label1.hidden = false
            label2.hidden = false
            label3.hidden = false
            label4.hidden = false
            weatherImage.hidden = false
            
            //print("They practice at \(zip) and at \(prefs.stringForKey("hour")!) ")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func enter(sender: AnyObject) {
        let date = practiceTime.date
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([NSCalendarUnit.Hour, NSCalendarUnit.Minute] , fromDate: date)
        prefs.setValue(components.hour, forKey: "hour")
        
        if let zipcode = zipCode.text {
            if let zip = Int(zipcode){
                prefs.setValue(zip, forKey:"zipcode")
            } else {
                viewDidLoad()
            }
        } else {
            viewDidLoad()
        }
        view.endEditing(true)
        zipCode.hidden = true
        practiceTime.hidden = true

        zipCodeLabel.hidden = true
        practiceTimeLabel.hidden = true
        realPracticeLabel.hidden = true
        editLocation.hidden = false
        viewDidLoad()
    }
    func hideButton() {
        enterButton.hidden = true
    }
    func changePicture(url: String) {
        let url = NSURL(string: url)
        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        weatherImage.image = UIImage(data: data!)
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    @IBAction func editLocation(sender: AnyObject) {
        zipCode.hidden = false
        practiceTime.hidden = false
        zipCodeLabel.hidden = false
        practiceTimeLabel.hidden = false
        realPracticeLabel.hidden = false
        editLocation.hidden = true
        label1.hidden = true
        label2.hidden = true
        label3.hidden = true
        label4.hidden = true
        weatherImage.hidden = true
        editLocation.hidden = true
        zipCode.text = prefs.stringForKey("zipcode")
        

    }
        

    
}


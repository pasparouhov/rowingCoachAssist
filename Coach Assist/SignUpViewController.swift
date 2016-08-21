//
//  SignUpViewController.swift
//  Coach Assist
//
//  Created by Pavel Asparouhov on 8/18/16.
//  Copyright © 2016 BigP inc. All rights reserved.
//

import UIKit
import Parse
class SignUpViewController: UIViewController {

    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var rowerOrCoach: UISegmentedControl!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password2: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        signUp.layer.cornerRadius = 5
        signUp.clipsToBounds = true
        signUp.backgroundColor = UIColor(red:0.93, green:0.44, blue:0.14, alpha:1.0)
        let attributes = [
            NSForegroundColorAttributeName: UIColor.grayColor(),
            
            NSFontAttributeName : UIFont(name: "BebasNeueLight", size: 21)! // Note the !
            
        ]
        setUnderline(email)
        setUnderline(password2)
        setUnderline(password)
        setUnderline(username)
        email.attributedPlaceholder = NSAttributedString(string: "Email", attributes:attributes)
        password.attributedPlaceholder = NSAttributedString(string: "Password", attributes:attributes)
        password2.attributedPlaceholder = NSAttributedString(string: "Re-enter password", attributes:attributes)
        username.attributedPlaceholder = NSAttributedString(string: "Username", attributes:attributes)
        var subViewOfSegment: UIView = rowerOrCoach.subviews[0] as UIView
        subViewOfSegment.tintColor = UIColor(red:0.93, green:0.44, blue:0.14, alpha:1.0)
        var subViewOfSegment2: UIView = rowerOrCoach.subviews[1] as UIView
        subViewOfSegment2.tintColor = UIColor(red:0.93, green:0.44, blue:0.14, alpha:1.0)
        


        /*Bebas Neue
            == BebasNeueBook
            == BebasNeueLight
            == BebasNeueBold
            == BebasNeue-Thin
            == BebasNeueRegular*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func setUnderline(textField: UITextField){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.grayColor().CGColor
        border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width:  textField.frame.size.width, height: textField.frame.size.height)
        
        border.borderWidth = width
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true

    }

    @IBAction func signUp(sender: AnyObject) {
        var username = ""
        var password = ""
        var password2 = ""
        var email = ""
        var view = ""
        if let username1 = self.username.text {
            username = username1
        }
        if let password1 = self.password.text {
            password = password1
        }
        if let password3 = self.password2.text {
            password2 = password3
        }
        if let email1 = self.email.text {
            email = email1
        }
        var finalEmail = email.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        // Validate the text fields
        if username.characters.count < 1 {
            var alert = UIAlertView(title: "Invalid", message: "Username must be greater than 1 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else if password.characters.count < 2 {
            var alert = UIAlertView(title: "Invalid", message: "Password must be greater than 2 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else if password != password2 {
            var alert = UIAlertView(title: "Invalid", message: "Passwords don't match", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else {
            // Run a spinner to show a task in progress
            var spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            spinner.startAnimating()
            
            var newUser = PFUser()
            
            newUser.username = username
            newUser.password = password
            newUser.email = finalEmail
            
            switch rowerOrCoach.selectedSegmentIndex {
            case 0:
                newUser.setObject(false, forKey: "coach")
                view = "RowerView"
            case 1:
                newUser.setObject(true, forKey: "coach")
                view = "TabBarController"
            default:
                break
            }
            
            // Sign up the user asynchronously
            newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                
                // Stop the spinner
                spinner.stopAnimating()
                if ((error) != nil) {
                    var displayError = ""
                    var errorString = String(error)
                    if errorString.rangeOfString("Email address") != nil{
                        displayError = "Email format is invalid"
                    } else if errorString.rangeOfString("Account already") != nil{
                        displayError = "Account already exists"
                    }
                    var alert = UIAlertView(title: "", message: displayError, delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                } else {
                    var alert = UIAlertView(title: "Success", message: "Signed Up", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(view) as! UIViewController
                        self.presentViewController(viewController, animated: true, completion: nil)
                    })
                }
            })
        }
    }
}


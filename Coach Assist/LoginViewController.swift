//
//  LoginViewController.swift
//  Coach Assist
//
//  Created by Pavel Asparouhov on 8/17/16.
//  Copyright © 2016 BigP inc. All rights reserved.
//

import UIKit
import Parse
class LoginViewController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var logIn: UIButton!
    @IBOutlet weak var signUp: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        logIn.layer.cornerRadius = 5
        logIn.clipsToBounds = true
        signUp.layer.cornerRadius = 5
        signUp.clipsToBounds = true
        setTextBox(password, string: "Password")
        setTextBox(username, string: "Username")
       
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
    func keyboardWasShown(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.signUp.frame.origin.y = keyboardFrame.size.height + 60
        })
    }
    func setTextBox(textField: UITextField, string: String){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.grayColor().CGColor
        border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width:  textField.frame.size.width, height: textField.frame.size.height)
        
        border.borderWidth = width
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
        let attributes = [
            NSForegroundColorAttributeName: UIColor.grayColor(),
            
            NSFontAttributeName : UIFont(name: "BebasNeueLight", size: 21)! // Note the !
            
        ]
        textField.attributedPlaceholder = NSAttributedString(string: string, attributes:attributes)

        
    }

    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {
        
        // for now, simply defining the method is sufficient.
        // we'll add code later
        
    }
    
    @IBAction func login(sender: AnyObject) {
        var username = ""
        var password = ""
        if let username1 =  self.username.text {
            username = username1
        }
        if let password1 =  self.password.text {
            password = password1
        }

        
        // Validate the text fields
        if username.characters.count < 1 {
            var alert = UIAlertView(title: "Invalid", message: "Username must be greater than 1 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else if password.characters.count < 2 {
            var alert = UIAlertView(title: "Invalid", message: "Password must be greater than 2 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else {
            // Run a spinner to show a task in progress
            var spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            spinner.startAnimating()
            
            // Send a request to login
            PFUser.logInWithUsernameInBackground(username, password: password, block: { (user, error) -> Void in
                
                // Stop the spinner
                spinner.stopAnimating()
                
                if ((user) != nil) {
                    var alert = UIAlertView(title: "Success", message: "Logged In", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let name = user!["coach"] as! Bool
                        var controller = ""
                        if name {
                            controller = "TabBarController"
                        } else {
                            controller = "RowerView"
                        }
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(controller) as! UIViewController
                        self.presentViewController(viewController, animated: true, completion: nil)
                    })
                    
                } else {
                    var alert = UIAlertView(title: "Error", message: "Username or password was incorrect", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }
            })
        }
    }

}

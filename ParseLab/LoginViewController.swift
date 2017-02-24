//
//  LoginViewController.swift
//  ParseLab
//
//  Created by Gates Zeng on 2/23/17.
//  Copyright © 2017 Gates Zeng. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose ofs any resources that can be recreated.
    }
    
    @IBAction func signUpClicked(_ sender: AnyObject) {
        let user = PFUser()
        user.username = emailField.text
        user.password = passwordField.text
        // other fields can be set just like with PFObject
        
        if (emailField.text?.isEmpty)! || (passwordField.text?.isEmpty)! {
            let signUpErrorController = UIAlertController(title: "Sign Up Failed", message: "Please enter Email and Password", preferredStyle: .alert)
            
            // create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
            }
            
            // add the OK action to the alert controller
            signUpErrorController.addAction(OKAction)
            
            self.present(signUpErrorController, animated: true)
        } else {
            print("Attempt to sign up")
            user.signUpInBackground(block: {
                (succeeded: Bool, error: Error?) -> Void in
                if let error = error {
                    print("Error on Sign Up")
                    let errorString = (error as NSError).userInfo["error"] as? NSString
                    let signUpErrorController = UIAlertController(title: "Sign Up Failed", message: "", preferredStyle: .alert)
                    
                    // create an OK action
                    let OKAction = UIAlertAction(title: "OK", style: .default)
                    
                    // add the OK action to the alert controller
                    signUpErrorController.addAction(OKAction)
                    
                    signUpErrorController.message = errorString as String!
                    self.present(signUpErrorController, animated: true)
                } else {
                    print("Successful Sign Up")
                    let alertController = UIAlertController(title: "Sign Up Successful", message: "Please log in using your new account", preferredStyle: .alert)
                    
                    // create an OK action
                    let OKAction = UIAlertAction(title: "OK", style: .default)
                    
                    // add the OK action to the alert controller
                    alertController.addAction(OKAction)
                    
                    self.present(alertController, animated: true)
                }
            })
        }
        

    }
    
    @IBAction func loginClicked(_ sender: AnyObject) {
        PFUser.logInWithUsername(inBackground: emailField.text!, password:passwordField.text!) {
            (user: PFUser?, error: Error?) -> Void in
            if user != nil {
                print("Login success")
                self.performSegue(withIdentifier: "showMessages", sender:nil)
                
            } else {
                print("Login failed")
                let errorString = (error as! NSError).userInfo["error"] as? NSString
                let signUpErrorController = UIAlertController(title: "Sign Up Failed", message: "", preferredStyle: .alert)
                
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .default)
                
                // add the OK action to the alert controller
                signUpErrorController.addAction(OKAction)
                
                signUpErrorController.message = errorString as String!
                self.present(signUpErrorController, animated: true)
            }
        }
    }
}


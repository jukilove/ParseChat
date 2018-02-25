//
//  SignUpViewController.swift
//  ParseChat
//
//  Created by Elizabeth on 2/25/18.
//  Copyright © 2018 Elizabeth. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        registerUser()
    }
    
    @IBAction func onLogin(_ sender: Any) {
        self.performSegue(withIdentifier: "haveAccountPageSegue", sender: sender)
    }
    
    func registerUser() {
    //initialize a user object
        let newUser = PFUser()
        
        //set user properties
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        newUser.email = emailField.text
        
        if((usernameField.text?.isEmpty)! || (passwordField.text?.isEmpty)! || (emailField.text?.isEmpty)! ) {
            let alertController = UIAlertController(title: "Sign Up Error", message: "Missing Username/Password/Email", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
        } else {
            // call sign up function on the object
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if let error = error {
                    let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        // handle response here.
                    }
                    // add the OK action to the alert controller
                    alertController.addAction(OKAction)
                    self.present(alertController, animated: true) {
                        // optional code for what happens after the alert controller has finished presenting
                    }
                   
                } else {
                    self.performSegue(withIdentifier: "signupLoginBackSegue", sender: nil)
                    print("User Registered successfully")
                    // manually segue to logged in view
                }
            }
        }
    }
        
/*
        //call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
               
                print(error.localizedDescription)
                
                if error._code == 202 {
                    print("The Username \(self.usernameField.text!) is taken")
                }
                
            } else {
                print("User Register Successfully")
                //manaully segue to logged in view
                self.performSegue(withIdentifier: "signupLoginBackSegue", sender: nil)
            }
        }
    }
*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

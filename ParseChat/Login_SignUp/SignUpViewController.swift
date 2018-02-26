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
            //initialize a user object
            let newUser = PFUser()
            
            //set user properties
            newUser.username = usernameField.text
            newUser.password = passwordField.text
            newUser.email = emailField.text
            
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if success {
                    print("New User Created")
                    self.performSegue(withIdentifier: "signupLoginBackSegue", sender: self)
                } else {
                   print("Error from SignUpViewController func registerUser()\(error!.localizedDescription)")
                }
                let alertController = UIAlertController(title: "Error Siging In", message: "\(String(describing: error!.localizedDescription))\nPlease try Again!", preferredStyle: .alert)
                let tryAgainAction = UIAlertAction(title: "Try Again", style: .default, handler: { (alert) in
                    alertController.dismiss(animated: true, completion: nil)
                })
                alertController.addAction(tryAgainAction)
                self.present(alertController, animated: true, completion: nil)
                
                }
            }
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

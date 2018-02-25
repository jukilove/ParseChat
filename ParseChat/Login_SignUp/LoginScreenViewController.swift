//
//  LoginScreenViewController.swift
//  ParseChat
//
//  Created by Elizabeth on 2/25/18.
//  Copyright © 2018 Elizabeth. All rights reserved.
//

import UIKit
import Parse

class LoginScreenViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func onLogin(_ sender: Any) {
        
        print("User tapped the login button")
       /*
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
     
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
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
    
                self.performSegue(withIdentifier: "LoginParsePageSegue", sender: self)
                print("User logged in successfully")
            }
        }
    }
 */
     PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) in
            if user != nil {
                self.usernameField.text = ""
                self.passwordField.text = ""
                print("User logged in successfully")
                self.performSegue(withIdentifier: "LoginParsePageSegue", sender: self)
                
            } else {
                print("User log in Failed: \(String(describing: error?.localizedDescription))")
                let alertController = UIAlertController(title: "Error Loging In", message: "\(String(describing: error?.localizedDescription))\nPlease try Again!", preferredStyle: .alert)
                let tryAgainAction = UIAlertAction(title: "Try Again", style: .default, handler: { (alert) in
                    alertController.dismiss(animated: true, completion: nil)
                })
                alertController.addAction(tryAgainAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }

    @IBAction func onSignup(_ sender: Any) {
        self.performSegue(withIdentifier: "signupPageSegue", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

//
//  ViewController.swift
//  Firebase_Example
//
//  Created by Lu Tam Long on 5/18/17.
//  Copyright © 2017 Lu Tam Long. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var txfEmail: UITextField!
    @IBOutlet weak var txfPassword: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
  
    @IBOutlet weak var btnLog: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLog.layer.borderWidth = 1
        btnLog.layer.borderColor = UIColor.black.cgColor
        btnLog.layer.cornerRadius = 5
        // Do any additional setup after loading the view, typically from a nib.
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

  
    @IBAction func btnLogInPressed(_ sender: Any) {
        //self.performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
        Auth.auth().signIn(withEmail: txfEmail.text!,password: txfPassword.text!) { user, error in
            if error == nil
            {
                
                /*let alertController = UIAlertController(title: "Success", message: "Account created!", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)*/
                self.performSegue(withIdentifier: "loginSuccess", sender: nil)
                
            }
            else {
                
                //Tells the user that there is an error and then gets firebase to tell them the error
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
        

    }

    @IBAction func btnSignUpPressed(_ sender: Any) {
        
        //create register message
        let alert = UIAlertController(title: "Register", message: "Register", preferredStyle: .alert)
        
        //create save button and action
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            //get text from message
            let emailField = alert.textFields![0]
            let passwordField = alert.textFields![1]
            
            Auth.auth().createUser(withEmail: emailField.text!,password: passwordField.text!) { user, error in
                if error == nil {
                    
                    let alertController = UIAlertController(title: "Success", message: "Account created!", preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    Auth.auth().signIn(withEmail: self.txfEmail.text!,password: self.txfPassword.text!)
                    
                    
                
                }
            }
        }

        
        //create cancel button and action
        let cancelAction = UIAlertAction(title: "Cancel",style: .default)
        
        //add text to message
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        //add action to message
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        //show
        present(alert, animated: true, completion: nil)
        
    }
}

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
import FBSDKLoginKit



class ViewController: UIViewController {

    @IBOutlet weak var txfEmail: UITextField!
    @IBOutlet weak var txfPassword: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    var isSignin = false
    @IBOutlet weak var btnForgot: UIButton!
  
    @IBOutlet weak var btnFB: UIButton!
    @IBOutlet weak var btnLog: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLog.layer.borderWidth = 1
        btnLog.layer.borderColor = UIColor.black.cgColor
        btnLog.layer.cornerRadius = 5
        
        btnFB.layer.borderWidth = 1
        btnFB.layer.borderColor = UIColor.black.cgColor
        btnFB.layer.cornerRadius = 5
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
                if (Auth.auth().currentUser?.isEmailVerified)!
                {
                    self.performSegue(withIdentifier: "loginSuccess", sender: nil)
                }
                else
                {
                    let alertController = UIAlertController(title: "Error", message: "Account not verified!", preferredStyle: .alert)
                    
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    let verifyAction = UIAlertAction(title: "Verify", style: .default) { action in
                        
                        Auth.auth().currentUser?.sendEmailVerification { (error) in
                            if error != nil{
                                print(error!.localizedDescription)
                            }
                            else
                            {
                                let sentAlertController = UIAlertController(title: "", message: "A verification email has been sent to your email!", preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                sentAlertController.addAction(okAction)
                                self.present(sentAlertController, animated: true, completion: nil)
                            }
                        }

                    }
                    alertController.addAction(verifyAction)
                    alertController.addAction(cancelAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
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
                    
                    let alertController = UIAlertController(title: "Success", message: "Account created! A verification email has been sent to your email. Please verify.", preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    Auth.auth().signIn(withEmail: self.txfEmail.text!,password: self.txfPassword.text!)
                    
                    Auth.auth().currentUser?.sendEmailVerification { (error) in
                        if error != nil{
                            print(error!.localizedDescription)
                        }
                    }
                    
                    
                    
                
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
    
    
    @IBAction func btnFBPressed(_ sender: Any) {
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            guard let accessToken = FBSDKAccessToken.current() else {
                print("Failed to get access token")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            // Perform login by calling Firebase APIs
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
                
                // Present the main view
                self.performSegue(withIdentifier: "loginSuccess", sender: nil)
            })
            
        }
    }
    
    @IBAction func btnForgotPressed(_ sender: Any) {
        
        //create register message
        let alert = UIAlertController(title: "Reset Password", message: "", preferredStyle: .alert)
        
        //create save button and action
        let resetAction = UIAlertAction(title: "Send", style: .default) { action in
            //get text from message
            let emailField = alert.textFields![0]
            
            Auth.auth().sendPasswordReset(withEmail: emailField.text!, completion: { (error) in
                if error == nil
                {
                    print("Email sent")
                }
            })
        }
    
    
        
        
        //create cancel button and action
        let cancelAction = UIAlertAction(title: "Cancel",style: .default)
        
        //add text to message
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
    
        
        //add action to message
        alert.addAction(resetAction)
        alert.addAction(cancelAction)
        
        //show
        present(alert, animated: true, completion: nil)

        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSuccess" {
            if let destinationVC = segue.destination as? MainViewController{
                destinationVC.isLogin = true
                
            }
        }
    }
}

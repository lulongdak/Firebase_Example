//
//  MainViewController.swift
//  Firebase_Example
//
//  Created by Lu Tam Long on 5/21/17.
//  Copyright © 2017 Lu Tam Long. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {

    @IBOutlet weak var idLabel: UILabel!
    var id:String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("\(Auth.auth().currentUser!.uid)")
        
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ViewStorage(_ sender: Any) {
        let storyboar = UIStoryboard(name: "Storage", bundle: Bundle.main)
        let controller = storyboar.instantiateViewController(withIdentifier: "Storageboar") as! StorageViewController
        self.present(controller, animated: true, completion: nil)
        
    }
    @IBAction func View_UserInfo(_ sender: Any) {
        let storyboar = UIStoryboard(name: "UserInfo", bundle: Bundle.main)
        let controller = storyboar.instantiateViewController(withIdentifier: "Userinfoboar") as! UserInfoViewController
        self.present(controller, animated: true, completion: nil)
    }
    @IBAction func LogOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("Sign out")
            
        }   catch let signOutError as NSError {
            print(signOutError)
        }
        let storyboar = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboar.instantiateViewController(withIdentifier: "Loginboar") as! ViewController
        self.present(controller, animated: true, completion: nil)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

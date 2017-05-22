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
    
    @IBOutlet weak var btnSignOut: UIButton!
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

    
    @IBAction func btnSignOutPressed(_ sender: Any) {
        if Auth.auth().currentUser != nil
        {
            do
            {
                try Auth.auth().signOut()
                self.performSegue(withIdentifier: "logOutSuccess", sender: nil)
            }
            catch let error as NSError {
                print(error.localizedDescription)
            }
        }
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

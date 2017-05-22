//
//  UserInfoViewController.swift
//  Firebase_Example
//
//  Created by Lu Tam Long on 5/22/17.
//  Copyright © 2017 Lu Tam Long. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class UserInfoViewController: UIViewController {

    @IBOutlet weak var textname: UITextField!
    @IBOutlet weak var textemail: UITextField!
    @IBOutlet weak var textphone: UITextField!
    let user = UserInfo()
    let rootRef = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.setInfor(name: "Lu Long", email: (Auth.auth().currentUser?.email!)!, phone: "01644004614")
        // Do any additional setup after loading the view.
      //  let barbtn: UIBarButtonItem = UIBarButtonItem()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let condition = rootRef.child("user_info").child(Auth.auth().currentUser!.uid)
        condition.observe( DataEventType.value, with: { (snapshot: DataSnapshot) in
           
            if let user = snapshot.value as? [String: AnyObject]{
                let info = UserInfo()
                info.setValuesForKeys(user)
                self.textname.text = info.name
                self.textemail.text = info.email
                self.textphone.text = info.phone
            }
        })
    }
    
    
    @IBAction func BacktoMenu(_ sender: Any) {
        self.LoadMainMenu()
    }
    
    @IBAction func Update_Action(_ sender: Any) {
        let key = rootRef.child("user_info").child(Auth.auth().currentUser!.uid).key
        let post = ["name": textname.text!,
                    "email": textemail.text!,
                    "phone": textphone.text!]
        let childupdate = ["/\(key)": post]
        rootRef.child("user_info").updateChildValues(childupdate)
    }
    
    @IBAction func Changepass_Action(_ sender: Any) {
        
    }
    
    func LoadMainMenu()
    {
        let storyboar = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboar.instantiateViewController(withIdentifier: "MenuAccount") as! MainViewController
        self.present(controller, animated: true, completion: nil)
        
    }
    
    func setInfor(name: String, email: String, phone: String){
        let path = rootRef.child("user_info").child(Auth.auth().currentUser!.uid)
        path.setValue(["name": name, "email": email,"phone": phone])
        
        
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

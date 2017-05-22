//
//  StorageViewController.swift
//  Firebase_Example
//
//  Created by Lu Tam Long on 5/21/17.
//  Copyright © 2017 Lu Tam Long. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import Darwin

class StorageViewController: UIViewController {

    @IBOutlet weak var statelbl: UILabel!
    @IBOutlet weak var delBtn: UIButton!
    var stateData = 0
    @IBOutlet weak var imgUI: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Upload_file(_ sender: Any) {
        let path = Auth.auth().currentUser!.uid + "/myava.jpg"
        let storageRef = Storage.storage().reference(withPath: path )
        let img = UIImage(named: "myava.jpg")
        let metadata = StorageMetadata()
        metadata.contentType="image/jpeg"
        storageRef.putData(UIImageJPEGRepresentation(img!, 1.0)!, metadata: metadata) { (data,error) in
            if error == nil {
                print("Upload success!")
                self.ArletNotice(title: "Upload", message: "Upload Success")
                
            }
            else{
                print(error?.localizedDescription ?? "Error")
                print("Upload failed!")
                self.ArletNotice(title: "Upload", message: "Upload Failed")
            }
          
        }
        imgUI.isHidden = true
        delBtn.isHidden = true
        
    }
    
    @IBAction func Download_file(_ sender: Any) {
       
        let path = Auth.auth().currentUser!.uid + "/myava.jpg"
        let storageRef = Storage.storage().reference(withPath: path )
        storageRef.getData(maxSize: INT64_MAX){ (data,error) in
            if error == nil {
                print("Download success")
                self.imgUI.image = UIImage(data: data!)
                self.imgUI.isHidden=false
                self.delBtn.isHidden = false;
                self.ArletNotice(title: "Download", message: "Download Success")
              
                
            }
            else {
                self.imgUI.isHidden=true
                print(error?.localizedDescription ?? "Error")
                print("Download failed")
                self.ArletNotice(title: "Download", message: "Download Failed")
               
            }
           
            
        }
        
        
    }
    
   
    @IBAction func Delete_Action(_ sender: Any) {
        self.statelbl.isHidden = true
        let path = Auth.auth().currentUser!.uid + "/myava.jpg"
        let storageRef = Storage.storage().reference(withPath: path )
        storageRef.delete(completion: { (error) in
            if error == nil {
                self.ArletNotice(title: "Delete", message: "Delete Success")
                print("Delete success")
            }
            else {
                print("Delete failed")
                self.ArletNotice(title: "Delete", message: "Delete Failed")
            }
        })

    }
    
    @IBAction func BacktoMenu(_ sender: Any) {
        self.LoadMainMenu()
    }
    
    @IBAction func Pause_Action(_ sender: Any) {
    }
    
    @IBAction func Resume_Action(_ sender: Any) {
    }
    
    @IBAction func Cancel_Action(_ sender: Any) {
    }
    
    func LoadMainMenu()
    {
        let storyboar = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboar.instantiateViewController(withIdentifier: "MenuAccount") as! MainViewController
        self.present(controller, animated: true, completion: nil)
        
    }

    func ArletNotice(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
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

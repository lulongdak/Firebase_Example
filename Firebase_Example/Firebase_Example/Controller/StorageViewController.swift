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
        let path = Auth.auth().currentUser!.uid + "/myava.jpg"          //path save file in Storage, name folder is your ID user
        let storageRef = Storage.storage().reference(withPath: path )   // Create reference with path
        let img = UIImage(named: "myava.jpg")                           //Image myava.jpg
        let metadata = StorageMetadata()                                //Create metadata of Storage file
        metadata.contentType="image/jpeg"                               //Content type
        storageRef.putData(UIImageJPEGRepresentation(img!, 1.0)!, metadata: metadata) { (data,error) in //Upload file
            if error == nil {                       // if uploading not error, file is upload successfully
                print("Upload success!")
                self.ArletNotice(title: "Upload", message: "Upload Success")        //notice "Upload success"
                
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
       
        let path = Auth.auth().currentUser!.uid + "/myava.jpg"          //path save file in Storage
        let storageRef = Storage.storage().reference(withPath: path )   //Create reference with path
        storageRef.getData(maxSize: INT64_MAX){ (data,error) in         //Get data file
            if error == nil {                                           //Download success
                print("Download success")
                self.imgUI.image = UIImage(data: data!)                 //Show image downloaded
                self.imgUI.isHidden=false
                self.delBtn.isHidden = false;
                self.ArletNotice(title: "Download", message: "Download Success")
              
                
            }
            else {                              // if error will not show anymore
                self.imgUI.isHidden=true
                self.delBtn.isHidden=true
                print(error?.localizedDescription ?? "Error")
                print("Download failed")
                self.ArletNotice(title: "Download", message: "Download Failed")
               
            }
           
            
        }
        
        
    }
    
   
    @IBAction func Delete_Action(_ sender: Any) {
        
        let path = Auth.auth().currentUser!.uid + "/myava.jpg"          //path file to delete
        let storageRef = Storage.storage().reference(withPath: path )   //Create reference
        storageRef.delete(completion: { (error) in                      //Delete
            if error == nil {                                           //Delete success
                self.ArletNotice(title: "Delete", message: "Delete Success")        //notice delete success
                print("Delete success")
                self.imgUI.isHidden=true                               //hidden image and
                self.delBtn.isHidden=true                               //button
                
            }
            else {
                print("Delete failed")                          //delete failed
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

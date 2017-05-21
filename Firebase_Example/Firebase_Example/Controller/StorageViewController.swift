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
        self.statelbl.isHidden = true
        let path = Auth.auth().currentUser!.uid + "/myava.jpg"
        let storageRef = Storage.storage().reference(withPath: path )
        let img = UIImage(named: "myava.jpg")
        let metadata = StorageMetadata()
        metadata.contentType="image/jpeg"
        storageRef.putData(UIImageJPEGRepresentation(img!, 1.0)!, metadata: metadata) { (data,error) in
            if error == nil {
               
                self.statelbl.text = "Upload Success"
                self.statelbl.isHidden=false
                print("Upload success!")
             
                
                
            }
            else{
                
                self.statelbl.text = "Upload failed"
                self.statelbl.isHidden=false
                print(error?.localizedDescription ?? "Error")
                print("Upload failed!")
            }
          
        }
        imgUI.isHidden = true
        delBtn.isHidden = true
        
    }
    
    @IBAction func Download_file(_ sender: Any) {
        self.statelbl.isHidden = true
        let path = Auth.auth().currentUser!.uid + "/myava.jpg"
        let storageRef = Storage.storage().reference(withPath: path )
        storageRef.getData(maxSize: 1*1024*1024){ (data,error) in
            if error == nil {
                print("Download success")
                self.statelbl.text = "Download Success"
                self.imgUI.image = UIImage(data: data!)
                self.imgUI.isHidden=false
                self.statelbl.isHidden=false;
                self.delBtn.isHidden = false;
              
                
            }
            else {
                self.imgUI.isHidden=true
                print(error?.localizedDescription ?? "Error")
                print("Download failed")
                self.statelbl.text = "Download failed"
                self.statelbl.isHidden=false;
               // sleep(5)
            }
           
            
        }
        
        
    }
    
   
    @IBAction func Delete_Action(_ sender: Any) {
        self.statelbl.isHidden = true
        let path = Auth.auth().currentUser!.uid + "/myava.jpg"
        let storageRef = Storage.storage().reference(withPath: path )
        storageRef.delete(completion: { (error) in
            if error == nil {
                self.statelbl.text = "Delete success"
                print("Delete success")
            }
            else {
                self.statelbl.text = "Delete failed"
                print("Delete failed")
            }
            self.statelbl.isHidden = false
        })

    }
    
    @IBAction func Pause_Action(_ sender: Any) {
    }
    
    @IBAction func Resume_Action(_ sender: Any) {
    }
    
    @IBAction func Cancel_Action(_ sender: Any) {
    }
    
    func Hiddentlbl(){
        statelbl.isHidden = true
    }
    
    
    func start()
    {
        if (stateData == 1)
        {
            self.statelbl.text = "Uploading...."
        }
        else
        {
            self.statelbl.text = "Downloading...."
        }
    }
    func complete()
    {
        if (stateData == 1)
        {
            self.statelbl.text = "Upload success"
        }
        else
        {
            self.statelbl.text = "Download success"
        }
        
    }
    
    func errorM(){
        if (stateData == 1)
        {
            self.statelbl.text = "Upload failed"
        }
        else
        {
            self.statelbl.text = "Download failed"
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

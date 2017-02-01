//
//  SettingsViewController.swift
//  Cuisine
//
//  Created by Lois van Vliet on 23-01-17.
//  Copyright © 2017 Lois van Vliet. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    let picker = UIImagePickerController()
    var userStorage: FIRStorageReference!
    var ref: FIRDatabaseReference?
    var databaseHandle: FIRDatabaseHandle?
    
    @IBOutlet weak var NameUser: UILabel!
    @IBOutlet weak var EmailUser: UILabel!
    @IBOutlet weak var PasswordUser: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    
    var userName: String!
    var userEmail: String!

    override func viewDidLoad() {
          super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        let storage = FIRStorage.storage().reference(forURL: "gs://cuisine-9474f.appspot.com")
        
        userStorage = storage.child("users")
        
        
        picker.delegate = self
        
        showImage()
  
        showUsername()

        
    
        self.imageUser.layer.cornerRadius = self.imageUser.frame.size.width / 2
        self.imageUser.clipsToBounds = true
    
     
        PasswordUser.text = "*********"
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- Shows profile picture:
    func showImage(){
        let userID = FIRAuth.auth()?.currentUser?.uid

        ref?.child("users").child(userID!).child("urlToImage").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let urlImage = snapshot.value as? String{
                
                if let url = NSURL(string: urlImage) {
                    
                    if let data = NSData(contentsOf: url as URL) {
                        self.imageUser.image = UIImage(data: data as Data)
                    }
                }
                
            }
        })
        
    }
    
    //MARK:- Shows Username
    func showUsername(){
        let userID = FIRAuth.auth()?.currentUser?.uid

        ref?.child("users").child(userID!).child("name").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let UserName = snapshot.value as? String{
                self.NameUser.text = "Welcome \(UserName)"
            }
        })
        
    }
    
    
    
    //MARK:- change username:
    @IBAction func changeNameButton(_ sender: Any) {
        let currentUser = FIRAuth.auth()!.currentUser!.uid
        
        let alertController = UIAlertController(title: "Change Username", message:
            
            "Do you want to change your username?", preferredStyle: UIAlertControllerStyle.alert)
        
        let changeAction = UIAlertAction(title: "Change",
                                       style: .default) { action in
                 
                            let nameField = alertController.textFields![0]
                            if let newName = nameField.text {
                                self.ref?.child("users").child(currentUser).updateChildValues(["name" : newName])
                                self.NameUser.text! = "Welcome \(newName)"
                            }
                }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        alertController.addTextField(configurationHandler: { (textField) -> Void in
            textField.text = ""
            textField.placeholder = "Enter new username"
        })
        
        alertController.addAction(changeAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK:- function to change Password
    //reference: http://stackoverflow.com/questions/35953867/changing-user-email-and-password-with-swift-and-firebase
    @IBAction func changePassword(_ sender: Any) {
        let alertController = UIAlertController(title: "Change Password", message:
            
            "Do you want to change your Password?", preferredStyle: UIAlertControllerStyle.alert)
        let changeAction = UIAlertAction(title: "Change",
                                         style: .default) { action in
                                            
                                            let namePassword = alertController.textFields![0]
                                            let checkPassword = alertController.textFields![1]
                                            if let newPassword = namePassword.text {
                                                if newPassword == checkPassword.text{
                                        
                                                    FIRAuth.auth()?.currentUser!.updatePassword(newPassword,  completion: { error in
                                                        if error != nil {
                                                            self.error()
                                                            print(error?.localizedDescription)
                                                        } else {
                                                            print("succes")
                                                        }
                                                    })
                                                }
                                                else{
                                                    self.error()
                                                }
                                                
                                            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alertController.addTextField(configurationHandler: { (textField) -> Void in
            textField.text = ""
            textField.placeholder = "Password"
        })
        alertController.addTextField(configurationHandler: { (textField) -> Void in
            textField.text = ""
            textField.placeholder = "Confirm Password "
        })
        
        
        alertController.addAction(cancelAction)
        alertController.addAction(changeAction)
        
        
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK:- Change picture
    @IBAction func changePicture(_ sender: Any) {
        
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
        
    }
    
    
    //MARK:- fuction to pick an image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
            self.imageUser.image = image
        }
        self.dismiss(animated: true, completion: nil)
    
    }
    
    //MARK:- Save an image
    func saveImage() {
        
        let userID = FIRAuth.auth()?.currentUser?.uid
        let changeRequest = FIRAuth.auth()!.currentUser!.profileChangeRequest()
        
        changeRequest.commitChanges(completion: nil)
        
        let imageRef = self.userStorage.child("\(userID).jpg")
        let data = UIImageJPEGRepresentation(self.imageUser.image!, 0.5)
        
        let uploadTask = imageRef.put(data!, metadata: nil, completion: { (metadata, err) in
            if err != nil {
                self.error()
            }
            
            imageRef.downloadURL(completion: {(url, er) in
                if er != nil {
                    print(er!.localizedDescription)
                    
                    self.error()
                    
                }
                
                if let url = url {
                        self.ref?.child("users").child(userID!).child("urlToImage").setValue(url.absoluteString)
                }
            })
        })
        
        uploadTask.resume()
    }
    

    //MARK:- Alertcontroller for when something fails. 
    func error(){
        let alertController = UIAlertController(title: "Something went wrong", message:
            
            "try again", preferredStyle: UIAlertControllerStyle.alert)
        
        
               let cancelAction = UIAlertAction(title: "Ok",
                                         style: .default)
        
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }


}

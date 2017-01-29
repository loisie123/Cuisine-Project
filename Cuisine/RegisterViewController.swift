//
//  RegisterViewController.swift
//  Cuisine
//
//  Created by Lois van Vliet on 10-01-17.
//  Copyright © 2017 Lois van Vliet. All rights reserved.
//

import UIKit
import Firebase



class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInpu: UITextField!
    @IBOutlet weak var confirmPasswordInput: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    let picker = UIImagePickerController()
    var userStorage: FIRStorageReference!
    var ref: FIRDatabaseReference!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        ref = FIRDatabase.database().reference()
        let storage = FIRStorage.storage().reference(forURL: "gs://cuisine-9474f.appspot.com")
        userStorage = storage.child("users")
        // Do any additional setup after loading the view.
    }
    
   
 
    @IBAction func selectPhotoImage(_ sender: Any) {
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
            self.profileImage.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func registreButton(_ sender: Any) {
        
        guard nameInput.text != "", emailInput.text != "", passwordInpu.text != "", confirmPasswordInput.text != "" else {return}
        
        if passwordInpu.text == confirmPasswordInput.text {
            FIRAuth.auth()?.createUser(withEmail: emailInput.text!, password: passwordInpu.text!, completion: { (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                
                if let user = user {
                    
                    let changeRequest = FIRAuth.auth()!.currentUser!.profileChangeRequest()
                    changeRequest.displayName = self.nameInput.text!
                    changeRequest.commitChanges(completion: nil)
                    
                    let imageRef = self.userStorage.child("\(user.uid).jpg")
                    let data = UIImageJPEGRepresentation(self.profileImage.image!, 0.5)
                    
                    let uploadTask = imageRef.put(data!, metadata: nil, completion: { (metadata,err) in
                        if err != nil {
                            print(err!.localizedDescription)
                        }
                        imageRef.downloadURL(completion: { (url, er) in
                            if er != nil{
                                print (er!.localizedDescription)
                            }
                            if let url = url{
                                let userInfo: [String:Any] = ["uid" : user.uid, "name" : self.nameInput.text!,
                                                              "urlToImage" : url.absoluteString]
                                
                                self.ref.child("users").child(user.uid).setValue(userInfo)
                                
                                let vc = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "usersVC")
                                self.present(vc, animated: true, completion: nil)

                                
                            }
                        })
                            
                    })
                    uploadTask.resume()
                    
                   
                    
                }
            
            
            })
            
            } else{
            let alertcontroller = UIAlertController(title: "Loggin failed", message: "Try again", preferredStyle: UIAlertControllerStyle.alert)

            let cancelAction = UIAlertAction(title: "Cancel", style: .default)
            alertcontroller.addAction(cancelAction)
            
            self.present(alertcontroller, animated: true, completion: nil)
       
        }
        
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

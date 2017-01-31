//
//  LoginViewController.swift
//  Cuisine
//
//  Created by Lois van Vliet on 11-01-17.
//  Copyright © 2017 Lois van Vliet. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailInput: UITextField!
    
    @IBOutlet weak var passwordInput: UITextField!
    
    var currentUser = String()
    var stringPicture = NSString()
    let color = UIColor(colorLiteralRed: 121, green: 172, blue: 43, alpha: 1.0)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAroung()
       

        // Do any additional setup after loading the view.
    }

    @IBAction func loginButton(_ sender: Any) {
        guard emailInput.text != "", passwordInput.text != "" else {return}
        
        FIRAuth.auth()?.signIn(withEmail: emailInput.text!, password: passwordInput.text!, completion: {(user, error) in
            
            if let error = error {
                
                self.showAlert(titleAlert: "Login Failed", messageAlert: "Try again")
                print (error.localizedDescription)

            }
            
            if self.emailInput.text! == "cormet123@gmail.com"{
                
                if let user = user{
                    self.performSegue(withIdentifier: "cormetVC", sender: nil)
                    }
                }
            else{
                if let user = user{
                    
                self.performSegue(withIdentifier: "usersVC", sender: nil)
                }
                }
        })
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension UIViewController{
    func hideKeyboardWhenTappedAroung(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
}


extension UIViewController{
   func showAlert(titleAlert: String , messageAlert: String){
    let alertcontroller = UIAlertController(title: titleAlert, message: messageAlert, preferredStyle: UIAlertControllerStyle.alert)
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .default)
    
    alertcontroller.addAction(cancelAction)
    
    self.present(alertcontroller, animated: true, completion: nil)
    
    
    }
    
}



















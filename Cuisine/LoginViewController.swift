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
    
    override func viewDidLoad() {
        checkIfSomeoneIsLoggedIn()
        
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        }
    
    
    //MARK:- LogIn
    @IBAction func loginButton(_ sender: Any) {
        guard emailInput.text != "", passwordInput.text != "" else {return}
        
        FIRAuth.auth()?.signIn(withEmail: emailInput.text!, password: passwordInput.text!, completion: {(user, error) in
            
            if let error = error {
                self.showAlert(titleAlert: "Login Failed", messageAlert: "Try again")
                
                self.emailInput.text = ""
                self.passwordInput.text = ""
                print (error.localizedDescription)

            }
            
            if self.emailInput.text! == "cormet123@gmail.com"{
                if user != nil{
                    self.performSegue(withIdentifier: "cormetVC", sender: nil)
                    }
                }
            else{
                if user != nil{
                    
                self.performSegue(withIdentifier: "usersVC", sender: nil)
                }
            }
        })
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK:- Automatic Log In Function
    func checkIfSomeoneIsLoggedIn(){
        //
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if user != nil && user?.email != "cormet123@gmail.com" {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "usersVC")
                self.present(vc, animated: true, completion: nil)
            } else if user?.email == "cormet123@gmail.com"{
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "cormetVC")
                self.present(vc, animated: true, completion: nil)
            }
        }
        
    }




}

























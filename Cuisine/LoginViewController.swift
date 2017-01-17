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
        super.viewDidLoad()
       

        // Do any additional setup after loading the view.
    }

    @IBAction func loginButton(_ sender: Any) {
        guard emailInput.text != "", passwordInput.text != "" else {return}
        
        FIRAuth.auth()?.signIn(withEmail: emailInput.text!, password: passwordInput.text!, completion: {(user, error) in
            
            if let error = error {
                print(error.localizedDescription)

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

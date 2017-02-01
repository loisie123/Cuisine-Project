//
//  CormetMenuViewController.swift
//  Cuisine
//
//  Created by Lois van Vliet on 24-01-17.
//  Copyright © 2017 Lois van Vliet. All rights reserved.
//
// Viewcontroller where the main menu for cormet is seen. 
//

import UIKit
import Firebase

class CormetMenuViewController: UIViewController {
    
    var ref:FIRDatabaseReference?
    var databaseHandle: FIRDatabaseHandle?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cormetLogOut(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: UIAlertControllerStyle.alert)
        
        let logOutAction = UIAlertAction(title: "Yes", style: .default) {action in
            let firebaseAuth = FIRAuth.auth()
            do {
                try firebaseAuth?.signOut()
                
            } catch let signOutError as NSError {
                
                self.showAlert(titleAlert: "Problems occured while siging out.", messageAlert: "Try again.")
                print ("Error signing out: %@", signOutError)
            }
            self.performSegue(withIdentifier: "logoutVC", sender: nil)
            
        }
        
        let cancelAction = UIAlertAction(title: "No", style: .default)
        
        alertController.addAction(cancelAction)
        alertController.addAction(logOutAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    



}





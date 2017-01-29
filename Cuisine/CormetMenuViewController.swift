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
    
    let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
    
            } catch let signOutError as NSError {
                
                showAlert(titleAlert: "Problems occured while siging out.", messageAlert: "Try again.")
                print ("Error signing out: %@", signOutError)
            }
    self.performSegue(withIdentifier: "logoutVC", sender: nil)
    
    }
    
    // When the user quits the app encode state.
    override func encodeRestorableState(with coder: NSCoder) {
        
        super.encodeRestorableState(with: coder)
    }
    
    // When the user opens the app. Decode state.
    override func decodeRestorableState(with coder: NSCoder) {
     
        super.decodeRestorableState(with: coder)
        
    }

}


// Restore view.
extension CormetMenuViewController: UIViewControllerRestoration {
    public static func viewController(withRestorationIdentifierPath identifierComponents: [Any],
                               coder: NSCoder) -> UIViewController? {
        let vc = CormetMenuViewController()
        return vc
    }
}



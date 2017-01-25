//
//  CormetMenuViewController.swift
//  Cuisine
//
//  Created by Lois van Vliet on 24-01-17.
//  Copyright © 2017 Lois van Vliet. All rights reserved.
//

import UIKit
import Firebase

class CormetMenuViewController: UIViewController {

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
    print("SIGNED OUT")
    } catch let signOutError as NSError {
    print ("Error signing out: %@", signOutError)
    }
    self.performSegue(withIdentifier: "logoutVC", sender: nil)
    
}


}

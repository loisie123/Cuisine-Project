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
    
    var ref:FIRDatabaseReference?
    var databaseHandle: FIRDatabaseHandle?
    
    var daysOfTheWeek = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        ref = FIRDatabase.database().reference()
        
    //get the day of the week
        ref?.child("cormet").child("different days").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let dictionary = snapshot.value as? NSDictionary
            self.daysOfTheWeek = dictionary?.allKeys as! [String]
            print(self.daysOfTheWeek)
            
        })

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "days"{
            let controller = segue.destination as! CormetDaysViewController
            
            controller.daysOfTheWeek = self.daysOfTheWeek
        }
        



}
}

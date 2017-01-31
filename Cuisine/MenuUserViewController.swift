//
//  MenuUserViewController.swift
//  Cuisine
//
//  Created by Lois van Vliet on 15-01-17.
//  Copyright © 2017 Lois van Vliet. All rights reserved.
//

import UIKit
import Firebase

class MenuUserViewController: UIViewController {
    
    
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var profiePicture: UIImageView!
    var ref:FIRDatabaseReference?
    var databaseHandle: FIRDatabaseHandle?
    var UserName = String()
    
    var daysOfTheWeek = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
        let userID =  FIRAuth.auth()?.currentUser?.uid
        
            ref?.child("users").child(userID!).child("urlToImage").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let urlImage = snapshot.value as! String
            
            if let url = NSURL(string: urlImage) {
                
                if let data = NSData(contentsOf: url as URL) {
                    self.profiePicture.image = UIImage(data: data as Data)
                }
            }
            })
        
        ref?.child("users").child(userID!).child("name").observeSingleEvent(of: .value, with: { (snapshot) in
          
            let UserName = snapshot.value as! String
            self.nameUser.text = "Welcome \(UserName)"
            
        })
        
    }
    @IBAction func LogOutButtonPressed(_ sender: Any) {
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






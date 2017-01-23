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
            print (snapshot.value)
            
            
            
        })
        
        
        //profiePicture.downloadImage(from: pictureString)
        
        
        
        
        
        //get the day of the week
        ref?.child("cormet").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let dictionary = snapshot.value as? NSDictionary
            self.daysOfTheWeek = dictionary?.allKeys as! [String]
            print(self.daysOfTheWeek)
            
        })

        // Do any additional setup after loading the view.
    }

    @IBAction func LogOutButton(_ sender: Any) {
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
        if segue.identifier == "letsgo"{
            let controller = segue.destination as! WeekTableViewController

            controller.daysOfTheWeek = self.daysOfTheWeek

        }
        if segue.identifier == "settings"{
            let settings = segue.destination as! SettingsViewController
            
            settings.NameUser.text = nameUser.text!
            //settings.EmailUser.text =

    }
    }
}





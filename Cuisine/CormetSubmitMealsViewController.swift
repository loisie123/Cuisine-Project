//
//  CormetSubmitMealsViewController.swift
//  Cuisine
//
//  Created by Lois van Vliet on 15-01-17.
//  Copyright © 2017 Lois van Vliet. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CormetSubmitMealsViewController: UIViewController {
    
    @IBOutlet weak var weekNumber: UILabel!
    @IBOutlet weak var dayNumber: UILabel!
    @IBOutlet weak var inputSoop: UITextField!
    @IBOutlet weak var priceSoop: UITextField!
    
    @IBOutlet weak var sandwichPrice: UITextField!
    @IBOutlet weak var nextDayButton: UIButton!
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var sandwichtInput: UITextField!
    
    @IBOutlet weak var priceDinner: UITextField!
    @IBOutlet weak var inputDinner: UITextField!
    
    var ref: FIRDatabaseReference?
    var databaseHandle: FIRDatabaseHandle?
    
    var daysOfTheWeek: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    var number: Int = 0
    
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        
        ref = FIRDatabase.database().reference()
            
        dayNumber.text = daysOfTheWeek[number]
        
        doneButton.isHidden = true
        

        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Action to add soop to the database
    @IBAction func inputSoopButton(_ sender: Any) {
        let user = FIRAuth.auth()?.currentUser?.uid
        
        if (self.inputSoop.text != "" && self.priceSoop.text != "" ){

            self.ref?.child("cormet").child(daysOfTheWeek[number]).child("soop").child(self.inputSoop.text!).child("nameSoop").setValue(self.inputSoop.text!)
            self.ref?.child("cormet").child(daysOfTheWeek[number]).child("soop").child(self.inputSoop.text!).child("priceSoop").setValue(self.priceSoop.text!)
            self.ref?.child("cormet").child(daysOfTheWeek[number]).child("soop").child(self.inputSoop.text!).child("likes").setValue(0)
        }
        else{
            let alertController = UIAlertController(title: "Empty box", message: "There is nothing to save", preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
        
        
    }
    
    
    //MARK: Action to go to the next day.
    @IBAction func NextDayButton(_ sender: Any) {
        
        if number != 4 {
            doneButton.isHidden = true
            nextDayButton.isHidden = false
       
            let alertController = UIAlertController(title: "Next day", message: "Do you want to go to the next day?", preferredStyle: UIAlertControllerStyle.alert)
        
            let nextDAy = UIAlertAction (title: "Next", style: .default) { action in
        
                self.number = self.number+1
                self.dayNumber.text = self.daysOfTheWeek[self.number]

            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
            alertController.addAction(nextDAy)
            alertController.addAction(cancelAction)
        
        
            present(alertController, animated: true, completion: nil)
            
            inputSoop.text = ""
            priceSoop.text = ""
            
        }
        else{
            doneButton.isHidden = false
            nextDayButton.isHidden = true
        }

    }
    
    
    
    @IBAction func addSanwich(_ sender: Any) {
        
        let user = FIRAuth.auth()?.currentUser?.uid
        
        if (self.sandwichtInput.text != "" && self.sandwichPrice.text != "" ){
            
            self.ref?.child("cormet").child(daysOfTheWeek[number]).child("Sandwich").child(self.sandwichtInput.text!).child("name").setValue(self.sandwichtInput.text!)
            self.ref?.child("cormet").child(daysOfTheWeek[number]).child("Sandwich").child(self.sandwichtInput.text!).child("price").setValue(self.sandwichPrice.text!)
            self.ref?.child("cormet").child(daysOfTheWeek[number]).child("Sandwich").child(self.sandwichtInput.text!).child("likes").setValue(0)
            
            sandwichtInput.text = ""
            sandwichPrice.text = ""
            
        }
        else{
            let alertController = UIAlertController(title: "Empty box", message: "There is nothing to save", preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func addDinnerButton(_ sender: Any) {
    
 
    let user = FIRAuth.auth()?.currentUser?.uid
    
        if (self.inputDinner.text != "" && self.priceDinner.text != "" ){
    
        self.ref?.child("cormet").child(daysOfTheWeek[number]).child("Dinner").child(self.inputDinner.text!).child("name").setValue(self.inputDinner.text!)
            self.ref?.child("cormet").child(daysOfTheWeek[number]).child("Dinner").child(self.inputDinner.text!).child("price").setValue(self.priceDinner.text!)
            self.ref?.child("cormet").child(daysOfTheWeek[number]).child("Dinner").child(self.inputDinner.text!).child("likes").setValue(0)
            
            inputDinner.text = ""
            priceDinner.text = ""
            
        }
            
        else{
            let alertController = UIAlertController(title: "Empty box", message: "There is nothing to save", preferredStyle: UIAlertControllerStyle.alert)
    
            let cancelAction = UIAlertAction(title: "Cancel", style: .default)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
            
    
        }
    }
    @IBAction func doneButton(_ sender: Any) {
        self.performSegue(withIdentifier: "cormetVC", sender: nil)
    }

    @IBAction func logOutButtonCormet(_ sender: Any) {
        
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




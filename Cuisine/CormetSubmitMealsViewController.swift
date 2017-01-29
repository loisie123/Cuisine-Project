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
    
    @IBOutlet weak var datePickerField: UITextField!
    @IBOutlet weak var inputSoop: UITextField!
    @IBOutlet weak var priceSoop: UITextField!
    
    @IBOutlet weak var sandwichPrice: UITextField!
 
    @IBOutlet weak var sandwichtInput: UITextField!
    
    @IBOutlet weak var priceDinner: UITextField!
    @IBOutlet weak var inputDinner: UITextField!
    
    var ref: FIRDatabaseReference?
    var databaseHandle: FIRDatabaseHandle?
    
    var daysOfTheWeek = [String]()
    var workingDays = [String]()
    var number: Int = 0
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAroung()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        createDatePicker()
    
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
    
    //MARK: Action to add soop to the database
    @IBAction func inputSoopButton(_ sender: Any) {
        
        if (self.inputSoop.text != "" && self.priceSoop.text != "" ){
            
            submitMeal(name: self.inputSoop.text!, price: self.priceSoop.text!, type: "Soup")
            
            inputSoop.text = ""
            priceSoop.text = ""
            
        }
        else{
            emptyFielAlert()
        }
    }
    
    
    
    
    @IBAction func addSanwich(_ sender: Any) {
        
        if (self.sandwichtInput.text != "" && self.sandwichPrice.text != "" ){
            
            submitMeal(name: self.sandwichtInput.text!, price: self.sandwichPrice.text!, type: "Sandwich")
            
            sandwichtInput.text = ""
            sandwichPrice.text = ""
            
        }
        else{
            emptyFielAlert()
        }
        
    }
    
    
    @IBAction func addDinnerButton(_ sender: Any) {
    
        if (self.inputDinner.text != "" && self.priceDinner.text != "" ){
            
            submitMeal(name: self.inputDinner.text!, price: self.priceDinner.text!, type: "Hot dish")
            
                inputDinner.text = ""
                priceDinner.text = ""
            
        }
            
        else{
            emptyFielAlert()
        }
    }

    
    
    
    //MARK: functie to create an datePicker
    func createDatePicker(){
        
        datePicker.datePickerMode = .date
      
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        datePickerField.inputAccessoryView = toolbar
        
        datePickerField.inputView = datePicker
        
    }
    
    func donePressed(){
      let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        datePickerField.text = formatter.string(from: datePicker.date)
        
        self.view.endEditing(true)
    }
  
    
    
    // reference: stackoverflow.nl
    func keyboardWillShow(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)? .cgRectValue{
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification){
         if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)? .cgRectValue{
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    

    func submitMeal(name: String, price: String, type: String){
        
        self.ref?.child("cormet").child("different days").child(datePickerField.text!).child(name).child("name").setValue(name)
        self.ref?.child("cormet").child("different days").child(datePickerField.text!).child(name).child("price").setValue(price)
        self.ref?.child("cormet").child("different days").child(datePickerField.text!).child(name).child("likes").setValue(0)
        self.ref?.child("cormet").child("different days").child(datePickerField.text!).child(name).child("type").setValue("soop")
        
    }
    
    
    func emptyFielAlert(){
        let alertController = UIAlertController(title: "Empty box", message: "There is nothing to save", preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
}


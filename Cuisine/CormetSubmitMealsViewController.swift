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
    
    let datePicker = UIDatePicker()
    var keyboardSizeRect: CGRect?
    
    override func viewDidLoad() {
        
    
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        createDatePicker()
    
        ref = FIRDatabase.database().reference()

        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Action to add soop to the database
    @IBAction func inputSoopButton(_ sender: Any) {
        
        if (self.inputSoop.text != "" && self.priceSoop.text != "" ){
            
            submitMeal(name: self.inputSoop.text!, price: self.priceSoop.text!, type: "Soup")
            
            inputSoop.text = ""
            priceSoop.text = ""
        }
        else{
            showAlert(titleAlert: "Empty box", messageAlert: "There is nothing to save")
        }
    }
    
    @IBAction func addSanwich(_ sender: Any) {
        
        if (self.sandwichtInput.text != "" && self.sandwichPrice.text != "" ){
            
            submitMeal(name: self.sandwichtInput.text!, price: self.sandwichPrice.text!, type: "Sandwich")
            
            sandwichtInput.text = ""
            sandwichPrice.text = ""
            
        }
        else{
             showAlert(titleAlert: "Empty box", messageAlert: "There is nothing to save")
        }
    }
    
    @IBAction func addDinnerButton(_ sender: Any) {
    
        if (self.inputDinner.text != "" && self.priceDinner.text != "" ){
            
            submitMeal(name: self.inputDinner.text!, price: self.priceDinner.text!, type: "Hot dish")
            
                inputDinner.text = ""
                priceDinner.text = ""
        }
        else{
             showAlert(titleAlert: "Empty box", messageAlert: "There is nothing to save")
        }
    }
    
    //MARK:- Function to create a datePicker
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
    
    //MARK:- Show keyboard and hide keyboard functions
    //reference: http://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift
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
    
    //MARK:- Save Dish in Firebase.
    func submitMeal(name: String, price: String, type: String){
        
        self.ref?.child("cormet").child("different days").child(datePickerField.text!).child(name).child("name").setValue(name)
        self.ref?.child("cormet").child("different days").child(datePickerField.text!).child(name).child("price").setValue(price)
        self.ref?.child("cormet").child("different days").child(datePickerField.text!).child(name).child("likes").setValue(0)
        self.ref?.child("cormet").child("different days").child(datePickerField.text!).child(name).child("type").setValue(type)
        
    }
    
}


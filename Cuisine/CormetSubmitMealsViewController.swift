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
        
        
        //daysOfTheWeek = formattedDaysInThisWeek()
       // workingDays = Array(daysOfTheWeek[1..<6])
       // print(workingDays)
    
        ref = FIRDatabase.database().reference()
        
        doneButton.isHidden = true
        
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

            self.ref?.child("cormet").child("different days").child(datePickerField.text!).child(self.inputSoop.text!).child("name").setValue(self.inputSoop.text!)
            self.ref?.child("cormet").child("different days").child(datePickerField.text!).child(self.inputSoop.text!).child("price").setValue(self.priceSoop.text!)
            self.ref?.child("cormet").child("different days").child(datePickerField.text!).child(self.inputSoop.text!).child("likes").setValue(0)
            self.ref?.child("cormet").child("different days").child(datePickerField.text!).child(self.inputSoop.text!).child("type").setValue("soop")
            
            //self.ref?.child("cormet").child(daysOfTheWeek[number]).child(self.sandwichtInput.text!).child("type").setValue("sandwich")
            
                inputSoop.text = ""
                priceSoop.text = ""
            
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
                self.dayNumber.text = self.workingDays[self.number]

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
            
            self.ref?.child("cormet").child("different days").child(datePickerField.text!).child(self.sandwichtInput.text!).child("name").setValue(self.sandwichtInput.text!)
            
            
            self.ref?.child("cormet").child("different days").child(datePickerField.text!).child(self.sandwichtInput.text!).child("price").setValue(self.sandwichPrice.text!)
            self.ref?.child("cormet").child("different days").child(datePickerField.text!).child(self.sandwichtInput.text!).child("likes").setValue(0)
            self.ref?.child("cormet").child("different days").child(datePickerField.text!).child(self.sandwichtInput.text!).child("type").setValue("sandwich")
            
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
            self.ref?.child("cormet").child("different days").child(datePickerField.text!).child(self.inputDinner.text!).child("name").setValue(self.inputDinner.text!)
            self.ref?.child("cormet").child("different days").child(datePickerField.text!).child(self.inputDinner.text!).child("price").setValue(self.priceDinner.text!)
            self.ref?.child("cormet").child("different days").child(datePickerField.text!).child(self.inputDinner.text!).child("likes").setValue(0)
            self.ref?.child("cormet").child("different days").child(datePickerField.text!).child(self.inputDinner.text!).child("type").setValue("dinner")
            
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

    /*
    // http://stackoverflow.com/questions/33109633/getting-weekdays-and-dates-for-a-week
    func formattedDaysInThisWeek() -> [String] {
        // create calendar
        let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!
        
        // today's date
        let today = NSDate()
        let todayComponent = calendar.components([.day, .month, .year], from: today as Date)
        
        // range of dates in this week
        let thisWeekDateRange = calendar.range(of: .day, in:.weekOfMonth, for:today as Date)
        
        // date interval from today to beginning of week
        let dayInterval = thisWeekDateRange.location - todayComponent.day!
        
        // date for beginning day of this week, ie. this week's Sunday's date
        let beginningOfWeek = calendar.date(byAdding: .day, value: dayInterval, to: today as Date, options: .matchNextTime)
        
        var formattedDays: [String] = []
        
        for i in 0 ..< thisWeekDateRange.length {
            let date = calendar.date(byAdding: .day, value: i, to: beginningOfWeek!, options: .matchNextTime)!
            formattedDays.append(formatDate(date: date as NSDate))
        }
        
        return formattedDays
    }
    
    func formatDate(date: NSDate) -> String {
        let format = " EEE MMM dd, yy"
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date as Date)
    }
    */
    
    
    
    
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
        
    
        //let date = formatDate(date: datePicker.date as NSDate)
        //datePickerField.text = "\(date)"
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "day"{
            let controller = segue.destination as! CormetDaysViewController
            
            controller.daysOfTheWeek = self.daysOfTheWeek
            
        }
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
    
    
    
    
}


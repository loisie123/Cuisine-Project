//
//  CormetStandaarAssortimentViewController.swift
//  Cuisine
//
//  Created by Lois van Vliet on 24-01-17.
//  Copyright © 2017 Lois van Vliet. All rights reserved.
//

import UIKit
import Firebase

class CormetStandaarAssortimentViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var inputPrice: UITextField!
    @IBOutlet weak var inputName: UITextField!
    let categories = ["Drinken","Wraps","MaaltijdSalades","Brood","vleeswaren"]
    
    @IBOutlet weak var categorieInput: UILabel!

    @IBOutlet weak var PickerView: UIPickerView!
    
    
    var ref: FIRDatabaseReference?
    var databaseHandle: FIRDatabaseHandle?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    ref = FIRDatabase.database().reference()
       
     
    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        categorieInput.text = categories[row]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveMealButton(_ sender: Any) {
        
        if inputName.text != "" && inputPrice.text != ""{
            
            self.ref?.child("cormet").child("standaard-assortiment").child(inputName.text!).child("name").setValue(inputName.text!)
            self.ref?.child("cormet").child("standaard-assortiment").child(inputName.text!).child("price").setValue(inputPrice.text!)
            self.ref?.child("cormet").child("standaard-assortiment").child(inputName.text!).child("likes").setValue(0)
            self.ref?.child("cormet").child("standaard-assortiment").child(inputName.text!).child("categorie").setValue(categorieInput.text!)
            
        
            inputName.text = ""
            inputPrice.text = ""

            
        } else{
            let alertController = UIAlertController(title: "Empty box", message: "There is nothing to save", preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
            
        }
        
        
        
        
    }
    
    

 

}

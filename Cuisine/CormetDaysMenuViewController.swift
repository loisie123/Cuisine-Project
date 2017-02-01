//
//  CormetDaysMenuViewController.swift
//  Cuisine
//
//  Created by Lois van Vliet on 26-01-17.
//  Copyright © 2017 Lois van Vliet. All rights reserved.
//

import UIKit
import Firebase


class CormetDaysMenuViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var mealsTableViewImage: UITableView!
    
    
    let types = ["Soup", "Sandwich" ,"Hot dish" ]
    
    var listAllNames = [[String]]()
    var listCategoryName = [String]()
    var listOfMeals = [meals]()
    
    var ref: FIRDatabaseReference?
    var databaseHandle: FIRDatabaseHandle?
    var day = String()
    
    
    override func viewDidLoad() {
        getMeals()
        
        super.viewDidLoad()
        dayNameLabel.text = day
        
        ref = FIRDatabase.database().reference()
        
        self.mealsTableViewImage.reloadData()
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- Make tableView with sections and a delete/change function.
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 25))
        
        returnedView = makeSectionHeader(returnedView: returnedView, section: section, listAllNames: self.listAllNames)
        return returnedView
    }
    

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            let index = indexPath.row
            let removelist = self.listAllNames[indexPath.section]
            let remove = removelist[index + 1]
            
            self.myDeleteFunctionExtra(firstTree: "different days", secondTree: self.day, childIWantToRemove: remove)
            self.viewDidLoad()
        }
        
        let change = UITableViewRowAction(style: .normal, title: "Wijzig") { (action, indexPath) in
            let index = indexPath.row
            let changelist = self.listAllNames[indexPath.section]
            let change = changelist[index + 1]
            
            let alertcontroller = UIAlertController(title: "Change Item", message: "Do you want to change price or name of this item?", preferredStyle: UIAlertControllerStyle.alert)
            
            let changeAction = UIAlertAction(title: "Change", style: .default) {action in
                
                //let newName = alertcontroller.textFields![0]
                let newPrice = alertcontroller.textFields![0]

                
//                if newName.text != ""{
//                    
//                    self.ref?.child("cormet").child("different days").child(self.day).child(change).updateChildValues(["name" : newName.text])
//                    print("is het gelukt?")
//                }
                if newPrice.text != "" {
                    self.ref?.child("cormet").child("different days").child(self.day).child(change).updateChildValues(["price" : newPrice.text!])
                }
                
                self.viewDidLoad()
 
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default)
            
            
//            alertcontroller.addTextField(configurationHandler: { (textField) -> Void in
//                textField.text = ""
//                textField.placeholder = "Enter new Name"
//            })
            alertcontroller.addTextField(configurationHandler: { (textField) -> Void in
                textField.text = ""
                textField.placeholder = "Enter new Price"
            })
            
            alertcontroller.addAction(cancelAction)
            alertcontroller.addAction(changeAction)
            
            self.present(alertcontroller, animated: true, completion: nil)
            
        }
        change.backgroundColor = UIColor.lightGray
        
        return [delete, change]
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listAllNames.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return listAllNames[section].count-1
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return listAllNames[section][0]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! CormetMenuDaysTableViewCell
      
        for meal in listOfMeals{
            if meal.name == listAllNames[indexPath.section][indexPath.row+1]{
                cell.nameLabel.text = meal.name
                cell.priceLabel.text = "€ \(meal.price!)"
                cell.likesLabel.text = " \(meal.likes!) likes"
            }
        }
        return cell
    }
  
    
    
    //MARK:- Get meals from firebase
    func getMeals(){
        
        let ref = FIRDatabase.database().reference()
        
        
        ref.child("cormet").child("different days").child(day).queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
   
            (self.listAllNames, self.listOfMeals) = self.getMealInformation(snapshot: snapshot, categories: self.types, kindOfCategorie: "type")

        self.mealsTableViewImage.reloadData()
        })

    }
}
    


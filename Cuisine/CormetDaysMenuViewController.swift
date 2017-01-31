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
    
    let types = ["Soup", "Sandwich" ,"Hot dish" ]
    
    var listAllNames = [[String]]()
    var listCategoryName = [String]()
    var listOfmeals = [meals]()
    
    var ref: FIRDatabaseReference?
    var databaseHandle: FIRDatabaseHandle?

    
    var day = String()
    @IBOutlet weak var mealsTableViewImage: UITableView!
    
    
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 25))
        let color = UIColor(red: 121.0/255.0, green: 172.0/255.0, blue: 43.0/255.0, alpha: 1.0)
        returnedView.backgroundColor = color
        let label = UILabel(frame: CGRect(x: 10, y: 7, width: view.frame.size.width, height: 25))
        label.text = self.listAllNames[section][0]
        label.textColor = .black
        returnedView.addSubview(label)
        
        return returnedView
    }
    
    
    // table view met sections en een delete functie
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            let index = indexPath.row
            let removelist = self.listAllNames[indexPath.section]
            let remove = removelist[index + 1]
            
            self.myDeleteFunction(firstTree: "different days", secondTree: self.day, childIWantToRemove: remove)
            self.viewDidLoad()
        }
        
        let change = UITableViewRowAction(style: .normal, title: "Wijzig") { (action, indexPath) in
            let index = indexPath.row
            let changelist = self.listAllNames[indexPath.section]
            let change = changelist[index + 1]
            
            let alertcontroller = UIAlertController(title: "Change Item", message: "Do you want to change price or name of this item?", preferredStyle: UIAlertControllerStyle.alert)
            
            let changeAction = UIAlertAction(title: "Change", style: .default) {action in
                
                let newName = alertcontroller.textFields![0]
                let newPrice = alertcontroller.textFields![1]

                
                if newName.text != ""{
                    
                    self.ref?.child("cormet").child("different days").child(self.day).child(change).updateChildValues(["name" : newName.text])
                    print("is het gelukt?")
                }
                if newPrice.text != "" {
                    self.ref?.child("cormet").child("different days").child(self.day).child(change).updateChildValues(["price" : newPrice.text])
                }
                
                print("ik wil wijzigen")
                self.viewDidLoad()
            
            
            
            
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default)
            
            
            alertcontroller.addTextField(configurationHandler: { (textField) -> Void in
                textField.text = ""
                textField.placeholder = "Enter new Name"
            })
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
       print (listAllNames)
        return listAllNames[section][0]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! CormetMenuDaysTableViewCell
        print(listAllNames)
        
        for meal in listOfmeals{
            if meal.name == listAllNames[indexPath.section][indexPath.row+1]{
                
                cell.nameLabel.text = meal.name
                cell.priceLabel.text = "€ \(meal.price!)"
                cell.likesLabel.text = " \(meal.likes!) likes"
            }
        }
        return cell
    }
  
    
    
    //MARK: Get meals from firebase
    func getMeals(){
        
        let ref = FIRDatabase.database().reference()
        
        
        ref.child("cormet").child("different days").child(day).queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
            
            let Dish = snapshot.value as! [String: AnyObject]
            self.listAllNames = [[String]]()
            self.listOfmeals = [meals]()
            
            for type in self.types{
                self.listCategoryName = [String]()
                self.listCategoryName.append(type)
                for (_, value) in Dish{
                    let mealsToShow = meals()
                    if let typ = value["type"] as? String{
                        if typ == type{
                            if let likes = value["likes"] as? Int, let name = value["name"] as? String, let price = value["price"] as? String{
                                
                                self.listCategoryName.append(name)
                                
                                mealsToShow.name = name
                                mealsToShow.likes = likes
                                mealsToShow.price = price
                                mealsToShow.typeOFMEal = type
                                
                                if let people = value["peoplewholike"] as? [String : AnyObject] {
                                    for (_,person) in people{
                                        
                                        mealsToShow.peopleWhoLike.append(person as! String)
                                    }
                                }
                                
                                self.listOfmeals.append(mealsToShow)
                            }
                        }
                    }
                }
                self.listAllNames.append(self.listCategoryName)
            }
            self.self.mealsTableViewImage.reloadData()
        })

    }

   
    
    //MARK: delete function. reference: http://stackoverflow.com/questions/39631998/how-to-delete-from-firebase-database
    override func myDeleteFunction(firstTree: String, secondTree: String, childIWantToRemove: String) {
 
        ref?.child("cormet").child(firstTree).child(secondTree).child(childIWantToRemove).removeValue { (error, ref) in
            if error != nil {
                print("error \(error)")
            }
            else{
                print ("removed")
            }
        }
    }
}
    


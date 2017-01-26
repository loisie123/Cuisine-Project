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
    
    
    var listNameSoop = ["Soup"]
    var listNameSandwich = ["Sandwiches"]
    var listNameDinner = ["Warm Eten"]
    
    var listAllNames = [[String]]()
    
    var listAll = [meals]()
    var daysOfTheWeek = [String]()
    
    var ref: FIRDatabaseReference?
    var databaseHandle: FIRDatabaseHandle?

    
    var day = String()
    @IBOutlet weak var mealsTableViewImage: UITableView!
    
    

    override func viewDidLoad() {
        listAllNames=[listNameSoop,listNameSandwich, listNameDinner]
         getMeals()
        super.viewDidLoad()
        dayNameLabel.text = day
        ref = FIRDatabase.database().reference()
        
        self.mealsTableViewImage.reloadData()
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
        
        for meal in listAll{
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
        listAllNames=[listNameSoop,listNameSandwich, listNameDinner]
        listNameSoop = ["Soup"]
        listNameSandwich = ["Sandwiches"]
        listNameDinner = ["Warm Eten"]
        
        let ref = FIRDatabase.database().reference()
        print(day)
        ref.child("cormet").child("different days").child(day).queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
            print("gebeurd dit")
            let Dish = snapshot.value as! [String: AnyObject]
            print (Dish)
            for (_, value) in Dish{
                let mealsToShow = meals()
                if let type = value["type"] as? String{
                    print (type)
                    if type == "soop"{
                        print ("het is soop")
                        if let likes = value["likes"] as? Int, let name = value["name"] as? String, let price = value["price"] as? String{
                            
                            self.listNameSoop.append(name)
                            
                            mealsToShow.name = name
                            mealsToShow.likes = likes
                            mealsToShow.price = price
                            mealsToShow.typeOFMEal = type
                            
                            if let people = value["peoplewholike"] as? [String : AnyObject] {
                                for (_,person) in people{
                                    
                                    mealsToShow.peopleWhoLike.append(person as! String)
                                }
                            }
                            
                            self.listAll.append(mealsToShow)
                            
                        }
                    }
                    else if type == "dinner"{
                        if let name = value["name"] as? String, let price = value["price"] as? String, let likes = value["likes"] as? Int{
                            mealsToShow.name = name
                            mealsToShow.likes = likes
                            mealsToShow.price = price
                            mealsToShow.typeOFMEal = type
                            
                            self.listNameDinner.append(name)
                            
                            if let people = value["peoplewholike"] as? [String : AnyObject] {
                                for (_,person) in people{
                                    mealsToShow.peopleWhoLike.append(person as! String)
                                }
                            }
                            self.listAll.append(mealsToShow)
                        }
                    }
                    else if type == "sandwich"{
                        if let name = value["name"] as? String, let price = value["price"] as? String, let likes = value["likes"] as? Int{
                            mealsToShow.name = name
                            mealsToShow.likes = likes
                            mealsToShow.price = price
                            mealsToShow.typeOFMEal = type
                            
                            self.listNameSandwich.append(name)
                            
                            if let people = value["peoplewholike"] as? [String : AnyObject] {
                                print (people)
                                for (_,person) in people{
                                    mealsToShow.peopleWhoLike.append(person as! String)
                                }
                            }
                            
                            self.listAll.append(mealsToShow)
                        }
                    }
                }
                self.listAllNames = [self.listNameSoop, self.listNameSandwich, self.listNameDinner]
                self.mealsTableViewImage.reloadData()
            }
        })
        
        ref.removeAllObservers()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "day"{
            let controller = segue.destination as! CormetDaysViewController
            
            controller.daysOfTheWeek = self.daysOfTheWeek
            
        }
    }
    
    
    //MARK: delete function. reference: http://stackoverflow.com/questions/39631998/how-to-delete-from-firebase-database
    func myDeleteFunction(firstTree: String, secondTree: String, childIWantToRemove: String) {
 
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
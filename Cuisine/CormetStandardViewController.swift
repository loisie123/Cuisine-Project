//
//  CormetStandardViewController.swift
//  Cuisine
//
//  Created by Lois van Vliet on 24-01-17.
//  Copyright © 2017 Lois van Vliet. All rights reserved.
//

import UIKit
import Firebase

class CormetStandardViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var ref: FIRDatabaseReference?
    var databaseHandle: FIRDatabaseHandle?
    
    let categories = ["Drinken","Wraps","MaaltijdSalades","Brood","vleeswaren"]
    
    var listAllNames = [[String]]()
    var listOfmeals = [meals]()
    var listCategoryName = [String]()
  
    
    @IBOutlet weak var standaardAssortimentTableView: UITableView!
    
    override func viewDidLoad() {
        getStandardAssortiment()

        super.viewDidLoad()        
        ref = FIRDatabase.database().reference()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return listAllNames.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let index = indexPath.row
            let removelist = listAllNames[indexPath.section]
            let remove = removelist[index + 1]
           
            myDeleteFunction(firstTree: "cormet", secondTree: "standaard-assortiment", childIWantToRemove: remove)
            
        }
        
        viewDidLoad()
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
        return listAllNames[section].count-1
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return listAllNames[section][0]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "standaardCell", for: indexPath) as! CormetStandaardTableViewCell
        //print(listAllNames)
        
        for meal in listOfmeals{
            if meal.name == listAllNames[indexPath.section][indexPath.row+1]{

              cell.nameMeal.text = meal.name
            
                cell.priceMeal.text = "€ \(meal.price!)"
               cell.likesMeal.text = " \(meal.likes!) likes"
                
                }
        }
        
        return cell
        
    }



    
    
    func getStandardAssortiment(){

        
        print("gaat hij hier doorheen")
        listAllNames.removeAll()
        let ref = FIRDatabase.database().reference()
        
       ref.child("cormet").child("standaard-assortiment").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
            print("ik wil dat hij hier doorheen gaat")
        
            let meal = snapshot.value as! [String:AnyObject]
            self.listAllNames = [[String]]()
            self.listOfmeals = [meals]()
        
        
        
            for category in self.categories{
                self.listCategoryName = [String]()
                self.listCategoryName.append(category)
                
                for (_,value) in meal{
                    
                    let showmeals = meals()
                    if let cat = value["categorie"] as? String{
                        
                        if cat == category{
                        
                            if let likes = value["likes"] as? Int, let name = value["name"] as? String, let price = value["price"] as? String{
                                self.listCategoryName.append(name)
                                showmeals.name = name
                                showmeals.price = price
                                showmeals.likes = likes
                                self.listOfmeals.append(showmeals)
                                
                        }
                    }
                }
                   
                    
                
            }
           // print(self.listCategoryName)
             self.listAllNames.append(self.listCategoryName)
            //print(self.listAllNames)
            
            }
        
        
        self.standaardAssortimentTableView.reloadData()
        })

        
        
    }
    
    //MARK: delete function. reference: http://stackoverflow.com/questions/39631998/how-to-delete-from-firebase-database
    func myDeleteFunction(firstTree: String, secondTree: String, childIWantToRemove: String) {
        
        
        
        ref?.child(firstTree).child(secondTree).child(childIWantToRemove).removeValue { (error, ref) in
            if error != nil {
                print("error \(error)")
            }
            else{
                print ("removed")
            }
            
            
        }
    
    }
    
    
    
    

}

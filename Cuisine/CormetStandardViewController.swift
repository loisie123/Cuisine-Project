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
        

        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        for catergory in categories{
            self.listAllNames.append([catergory])
        }
        
        ref = FIRDatabase.database().reference()
        
        getStandardAssortiment()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let remove = listAllNames[indexPath.section][indexPath.row]
            listAllNames.remove(at: [indexPath.section][indexPath.row])
            //standaardAssortimentTableView.deleteRows(at: [indexPath.section][indexPath.row], with: .fade)
            myDeleteFunction(firstTree: "cormet", secondTree: "standaard-assortement", childIWantToRemove: remove)
        }
        
        self.standaardAssortimentTableView.reloadData()
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(listAllNames)
        return listAllNames[section].count-1
        
    }
   // func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //    return listAllNames[section][0]
    //}

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "standaardCell", for: indexPath) as! CormetStandaardTableViewCell
        
        for meal in listOfmeals{
            if meal.name == listAllNames[indexPath.section][indexPath.row+1]{
                cell.nameMeal.text = meal.name
                cell.priceMeal.text == "€ \(meal.price!)"
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
            
            for category in self.categories{
                print (category)
                let listCategoryName = [category]
                let showmeals = meals()
                for (_,value) in meal{
                    print (value)
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
            self.listAllNames.append(listCategoryName)
            self.listCategoryName.removeAll()
            self.standaardAssortimentTableView.reloadData()
            }
        })
     
        
        
    }
    
    //MARK: delete function. reference: http://stackoverflow.com/questions/39631998/how-to-delete-from-firebase-database
    func myDeleteFunction(firstTree: String, secondTree: String, childIWantToRemove: String) {
        
        let user =  FIRAuth.auth()?.currentUser?.uid
        
        ref?.child(user!).child(firstTree).child(secondTree).child(childIWantToRemove).removeValue { (error, ref) in
            if error != nil {
                print("error \(error)")
            }
            else{
                print ("removed")
            }
            
            
        }
    
    }
    
    
    
    

}

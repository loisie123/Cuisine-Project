//
//  UserStandardAssortimenViewController.swift
//  Cuisine
//
//  Created by Lois van Vliet on 25-01-17.
//  Copyright © 2017 Lois van Vliet. All rights reserved.
//

import UIKit
import Firebase

class UserStandardAssortimenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var userStandardTableView: UITableView!
    
        var ref: FIRDatabaseReference?
        var databaseHandle: FIRDatabaseHandle?
    
        let categories = ["Bread", "Dairy", "Drinks", "Fruits", "Salads", "Warm food", "Wraps", "Remaining Categories"]
    
        var listAllNames = [[String]]()
        var listOfmeals = [meals]()
        var listCategoryName = [String]()
    
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
    
    

        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
                let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 25))
                let color = UIColor(red: 121.0/255.0, green: 172.0/255.0, blue: 43.0/255.0, alpha: 1.0)
                returnedView.backgroundColor = color
            
                let label = UILabel(frame: CGRect(x: 10, y: 7, width: view.frame.size.width, height: 25))
                label.textColor = .black
                returnedView.addSubview(label)
                
                return returnedView
        }
    

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 100
            
         }
         
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return listAllNames[section].count-1
         }
         
         func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return listAllNames[section][0]

         }
   
    
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
            let cell = tableView.dequeueReusableCell(withIdentifier: "userStandaardCell", for: indexPath) as! UserStandardTableViewCell
    
            for meal in listOfmeals{
                if meal.name == listAllNames[indexPath.section][indexPath.row+1]{
                    
                    cell.nameLabel.text = meal.name
                    cell.priceLabel.text = "€ \(meal.price!)"
                    cell.likedLabel.text = " \(meal.likes!) likes"
                    
                    // Check if user already like the dish
                    if meal.likes != 0 {
                        
                        for person in meal.peopleWhoLike{
                            if person == FIRAuth.auth()!.currentUser!.uid{
                                print ("true")
                                cell.unlikeButton.isHidden = false
                                cell.likeButton.isHidden = true
                            }
                            else {
                                cell.likeButton.isHidden = false
                                cell.unlikeButton.isHidden = true
                            }
                        }
                    } else{
                        cell.likeButton.isHidden = false
                        cell.unlikeButton.isHidden = true
                    }
                }
            }
            return cell
         }
    
    
    
    func getStandardAssortiment(){

        listAllNames.removeAll()
        let ref = FIRDatabase.database().reference()
        
        ref.child("cormet").child("standaard-assortiment").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
            
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
                self.listAllNames.append(self.listCategoryName)
            }
            self.userStandardTableView.reloadData()
        })
    }
}

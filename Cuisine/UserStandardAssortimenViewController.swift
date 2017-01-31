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
    
    func getStandardAssortiment(){
        
        listAllNames = [[String]]()
        listOfmeals = [meals]()
        
        let ref = FIRDatabase.database().reference()
        let categories = ["Bread", "Dairy", "Drinks", "Fruits", "Salads", "Warm food", "Wraps", "Remaining Categories"]
        
        ref.child("cormet").child("standaard-assortiment").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
            
            (self.listAllNames, self.listOfmeals) = self.getMealInformation(snapshot: snapshot, categories: categories, kindOfCategorie: "categorie")
            self.userStandardTableView.reloadData()
        })
        }
    
    

       func numberOfSections(in tableView: UITableView) -> Int {
         return listAllNames.count
         }
    
    

        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
                var returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 25))
            
                returnedView = makeSectionHeader(returnedView: returnedView, section: section, listAllNames: self.listAllNames)
                
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
    
    }

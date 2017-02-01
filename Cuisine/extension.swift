//
//  extension.swift
//  Cuisine
//
//  Created by Lois van Vliet on 31-01-17.
//  Copyright © 2017 Lois van Vliet. All rights reserved.
//

import Foundation
import Firebase



extension UIViewController{
    //MARK: delete function. reference: http://stackoverflow.com/questions/39631998/how-to-delete-from-firebase-database
    
    func myDeleteFunction(firstTree: String, secondTree: String, childIWantToRemove: String) {
        var ref:FIRDatabaseReference?
        
        ref = FIRDatabase.database().reference()
        ref?.child(firstTree).child(secondTree).child(childIWantToRemove).removeValue { (error, ref) in
            if error != nil {
                print("error \(error)")
            }
            else{
                print ("removed")
            }
            
            
        }
    }
    
    func getWeekDays(snapshot: FIRDataSnapshot) -> ([String]){
        let ref = FIRDatabase.database().reference()
        
        let dictionary = snapshot.value as? NSDictionary
        let array = dictionary?.allKeys as! [String]
        let days = array.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        return days
        
        
    }
    
    
    func makeSectionHeader(returnedView: UIView, section : Int , listAllNames: [[String]]) -> (UIView){
        let color = UIColor(red: 121.0/255.0, green: 172.0/255.0, blue: 43.0/255.0, alpha: 0.5)
        returnedView.backgroundColor = color
        let label = UILabel(frame: CGRect(x: 5, y: 5, width: view.frame.size.width, height: 20))
        
       label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 18)
        //label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = listAllNames[section][0]
        label.textColor = .black
        returnedView.addSubview(label)
        
        return returnedView
    }
    

   
    
    
    func getMealInformation(snapshot: FIRDataSnapshot, categories: [String], kindOfCategorie: String) -> ([[String]], [meals]) {
        print("punt 1")
        
        let meal = snapshot.value as! [String:AnyObject]
        var listAllNames = [[String]]()
        var listOfmeals = [meals]()
        
        let categorie = categories 
        
        for category in categorie {
            var listCategoryName = [String]()
            listCategoryName.append(category)
            
            print("punt 2")
            for (_,value) in meal{
                
                let showmeals = meals()
                if let cat = value[kindOfCategorie] as? String{
                    
                    if cat == category{
                        print("cat is gelijk aan category")
                        if let likes = value["likes"] as? Int, let name = value["name"] as? String, let price = value["price"] as? String{
                            print ("punt 88")
                            listCategoryName.append(name)
                            showmeals.name = name
                            showmeals.price = price
                            showmeals.likes = likes
                            showmeals.typeOFMEal = category
                            
                            if let days = value["day"] as? String{
                                showmeals.day = days
                            }
                            
                            
                            if let people = value["peoplewholike"] as? [String : AnyObject] {
                                for (_,person) in people{
                                    
                                    showmeals.peopleWhoLike.append(person as! String)
                                }
                            }

                            listOfmeals.append(showmeals)
                            print("listofmeals")
                        }
                    }
                }
            }
            listAllNames.append(listCategoryName)
        }
        
     return (listAllNames, listOfmeals)
    }}




extension UITableViewCell{
    func saveMeal(user: String, name: String, price: String, count: Int, type : String, day: String, child: String){
        
        let ref = FIRDatabase.database().reference()
        
        ref.child("users").child(user).child("likes").child(name).child("name").setValue(name)
        ref.child("users").child(user).child("likes").child(name).child("price").setValue(price)
        ref.child("users").child(user).child("likes").child(name).child("likes").setValue(count)
        ref.child("users").child(user).child("likes").child(name).child("day").setValue(day)
        ref.child("users").child(user).child("likes").child(name).child("type").setValue(type)
        ref.child("users").child(user).child("likes").child(name).child("child").setValue(child)
        
    }
}

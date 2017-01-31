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
    
    
//    func getStandardAssortiment( tableview: UITableView) -> (array1: [[String]], array2: [meals]){
//        var listAllNames = [[String]]()
//        var listOfmeals = [meals]()
//        
//        print ("wanneer gaat hij hier doorheen")
//
//        
//        let categories = ["Bread", "Dairy", "Drinks", "Fruits", "Salads", "Warm food", "Wraps", "Remaining Categories"]
//        
//        let ref = FIRDatabase.database().reference()
//        
//        ref.child("cormet").child("standaard-assortiment").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
//            
//            print("punt 1")
//            
//            let meal = snapshot.value as! [String:AnyObject]
//            listAllNames = [[String]]()
//            listOfmeals = [meals]()
//            
//            for category in categories{
//                var listCategoryName = [String]()
//                listCategoryName.append(category)
//                
//                print("punt 2")
//                for (_,value) in meal{
//                    
//                    let showmeals = meals()
//                    if let cat = value["categorie"] as? String{
//                        
//                        if cat == category{
//                            print("cat is gelijk aan category")
//                            if let likes = value["likes"] as? Int, let name = value["name"] as? String, let price = value["price"] as? String{
//                                print ("punt 88")
//                                listCategoryName.append(name)
//                                showmeals.name = name
//                                showmeals.price = price
//                                showmeals.likes = likes
//                                listOfmeals.append(showmeals)
//                                print("listofmeals")
//                            }
//                        }
//                    }
//                }
//                print("listCategoryName: \(listCategoryName)")
//                listAllNames.append(listCategoryName)
//            }
//            
//        self.LoadViewAgain(tablevie: tableview, listAllnames: listAllNames, listofMeals: listOfmeals)
//            
//        
//        
//        
//        })
//        print (listAllNames)
//        print(listOfmeals)
//        return (listAllNames, listOfmeals)
//        
//    }
    
    func LoadViewAgain(tablevie: UITableView, listAllnames: [[String]], listofMeals: [meals]) {
        
        tablevie.reloadData()
        
    }
    
    
    
    
    
}

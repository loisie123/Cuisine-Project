//
//  TodayMealsViewController.swift
//  Cuisine
//
//  Created by Lois van Vliet on 13-01-17.
//  Copyright © 2017 Lois van Vliet. All rights reserved.
//

import UIKit
import Firebase


class TodayMealsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewImage: UITableView!

    
    var listOfmeals = [meals]()
    var listOFSoop = [meals]()
    var listOFSandwiches = [meals]()
    var listNameSoop = [String]()
    var listNameSandwich = [String]()
    var listNameDinner = [String]()
    var listPriceSoop = [String]()
    var listPriceSandwich = [String]()
    var listPriceDinner = [String]()
    var listLikesSoop = [Int]()
    var listLikesSandwich = [Int]()
    var listLikesDinner = [Int]()
    
    
    var ref: FIRDatabaseReference?
    var databaseHandle: FIRDatabaseHandle?
    var meal = [String]()
    var prices = [String]()
    var likes = [Int]()
    var day = String()
    var listAllNames = [[String]]()
    var listAllLikes = [[Int]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        print(day)
        ref = FIRDatabase.database().reference()
        getMeals()

        self.tableViewImage.reloadData()
        
        print ("show table view")
        // Do any additional setup after loading the view.
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return  listAllNames.count
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //  print ("hoi")
    // print (listOfmeals.count + listOFSoop.count + listOFSandwiches.count)
        return listAllNames[section].count
    
    }

    
    
    //MARK: reference to my own github
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mealcell = tableView.dequeueReusableCell(withIdentifier: "mealCell", for: indexPath) as! MealsTodayTableViewCell
        mealcell.nameMeal.text = listAllNames[indexPath.section][indexPath.row]
        //mealcell.numberOfLikes.text = listAllLikes[indexPath.section][indexPath.row]
        
        
        print ("sandwiches")
        print(listOFSandwiches)
        print("dinner")
        print(listOfmeals)
        print("soop")
        print(listOFSoop)
        
        //print(meal[indexPath.row])
        //mealcell.nameMeal.text = meal[indexPath.row]
        //mealcell.numberOfLikes.text = likes[indexPath.row]
        return mealcell
    
    }
    
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.tableViewImage.deleteRows(at: [indexPath], with: .fade)
        }
        
        
        let like = UITableViewRowAction(style: .normal, title:"Like"){ (action, indexPath) in
            self.tableViewImage.deleteRows(at: [indexPath], with: .fade)
    
        }
        
        like.backgroundColor = UIColor.blue
        delete.backgroundColor = UIColor.red
        
        return [delete, like]
        }
    
    
    func getMeals(){
        print ("gebeurd dit uberhaupt wel")
        let ref = FIRDatabase.database().reference()
        ref.child("cormet").child(day).queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
            
            let Dish = snapshot.value as! [String: AnyObject]
            for (_, value) in Dish{
                let mealsToShow = meals()
                if let type = value["type"] as? String{
                    print (type)
                    if type == "soop"{
                        print ("het is soop")
                        if let likes = value["likes"] as? Int{                            print ("true")
                            if let name = value["name"] as? String, let price = value["price"] as? String{

                            
                            
                            mealsToShow.name = name
                            mealsToShow.likes = likes
                            mealsToShow.price = price
                            mealsToShow.typeOFMEal = type

                            self.listNameSoop.append(name)
                            
                            print("ik wil dat dit werkt")
                            print(self.listNameSoop)
                            self.listPriceSoop.append(price)
                            self.listLikesSoop.append(likes)
                            
                            self.listOFSoop.append(mealsToShow)
                            }}
                        else {print ("false")
                        }
                    }
                    else if type == "dinner"{
                        if let name = value["name"] as? String, let price = value["price"] as? String, let likes = value["likes"] as? Int{
                            mealsToShow.name = name
                            mealsToShow.likes = likes
                            mealsToShow.price = price
                            mealsToShow.typeOFMEal = type
                            
                            self.listNameDinner.append(name)
                            self.listPriceDinner.append(price)
                            self.listLikesDinner.append(likes)
                            
                            self.listOfmeals.append(mealsToShow)
                        }
                        }
                   else if type == "sandwich"{
                        if let name = value["name"] as? String, let price = value["price"] as? String, let likes = value["likes"] as? Int{
                            mealsToShow.name = name
                            mealsToShow.likes = likes
                            mealsToShow.price = price
                            mealsToShow.typeOFMEal = type
                            
                            self.listNameSandwich.append(name)
                            self.listPriceSandwich.append(price)
                            self.listLikesSandwich.append(likes)
                            self.listOFSandwiches.append(mealsToShow)
                        }
                        }
                    else{
                        print ("false")
                    }
                    
                        
                    }
                }
            self.listAllNames = [self.listNameSoop, self.listNameSandwich, self.listNameDinner]
            print("hoooooooooooooiiiiiiii")
            print (self.listAllNames)
             _ = [self.listPriceSoop, self.listPriceSandwich, self.listPriceDinner]
            //self.listAllLikes = [self.listLikesSoop, self.listLikesSandwich, self.listPriceDinner as! Array<Int>]
            self.tableViewImage.reloadData()
        })
        
        ref.removeAllObservers()
    
   
    }
    
}

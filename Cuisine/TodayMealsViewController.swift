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

    @IBOutlet weak var nameDay: UILabel!
    
    var listOfmeals = [meals]()
    var listNameSoop = ["soup"]
    var listNameSandwich = ["Sandwiches"]
    var listNameDinner = ["Warm Eten"]
    var listAll = [meals]()
    var daysOfTheWeek = [String]()
    
    var ref: FIRDatabaseReference?
    var databaseHandle: FIRDatabaseHandle?
    
    var meal = [String]()
    var prices = [String]()
    var likes = [Int]()
    var day = String()
    
    var listAllNames = [[String]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameDay.text = day
        print(day)
        
        
        ref = FIRDatabase.database().reference()
        getMeals()

        self.tableViewImage.reloadData()
        
        print ("show table view")
        
        //get the day of the week
        ref?.child("cormet").child("different days").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let dictionary = snapshot.value as? NSDictionary
            self.daysOfTheWeek = dictionary?.allKeys as! [String]
            print(self.daysOfTheWeek)
            
        })
        // Do any additional setup after loading the view.
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return  listAllNames.count
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listAllNames[section].count-1
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return listAllNames[section][0]
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 25))
        returnedView.backgroundColor = .red
        
        let label = UILabel(frame: CGRect(x: 10, y: 7, width: view.frame.size.width, height: 25))
        label.text = self.listAllNames[section][0]
        label.textColor = .black
        returnedView.addSubview(label)
        
        return returnedView
    }
    
    
    //MARK: reference to my own github
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let mealcell = tableView.dequeueReusableCell(withIdentifier: "mealCell", for: indexPath) as! MealsTodayTableViewCell

            mealcell.likeButton.isHidden = true
            mealcell.unlikeButton.isHidden = true
        for meal in listAll{
            if meal.name == listAllNames[indexPath.section][indexPath.row+1]{
                mealcell.nameMeal.text = meal.name
                mealcell.priceMeal.text = "€ \(meal.price!)"
                mealcell.numberOfLikes.text = " \(meal.likes!) likes"
                mealcell.day = day
                mealcell.typeMealLiked = meal.typeOFMEal
                
                if meal.likes != 0 {
                    for person in meal.peopleWhoLike{
                        print (person)
                        let user = FIRAuth.auth()!.currentUser!.uid
                        print ("dit is user \(user)")
                        if person == FIRAuth.auth()!.currentUser!.uid{
                            print ("true")
                            //mealcell.likeButton.isHidden = true
                            mealcell.unlikeButton.isHidden = false
                            }
                        }
                
                } else{
                    mealcell.likeButton.isHidden = false
                    //mealcell.unlikeButton.isHidden = true
                    }
            }
        }
        
        return mealcell
    
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    
    //MARK: Get meals from firebase
    func getMeals(){
        
               
        let ref = FIRDatabase.database().reference()
        ref.child("cormet").child("different days").child(day).queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
            
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
            self.tableViewImage.reloadData()
            }
        })
        
        ref.removeAllObservers()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "letsgo"{
            let controller = segue.destination as! WeekTableViewController
            
            controller.daysOfTheWeek = self.daysOfTheWeek
            
        }
    }
    
    
}

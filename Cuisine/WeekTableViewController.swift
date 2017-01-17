//
//  WeekTableViewController.swift
//  Cuisine
//
//  Created by Lois van Vliet on 15-01-17.
//  Copyright © 2017 Lois van Vliet. All rights reserved.
//

import UIKit
import Firebase

class WeekTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tableViewImage: UITableView!
    
    var ref:FIRDatabaseReference?
    var databaseHandle: FIRDatabaseHandle?
    
    
    
    var daysOfTheWeek = [String]()
    var number: Int = 0
    var kindOfMeals = [String]()
    var prices = [String]()
    var numberOflikes = [String]()
    var nameDish = [String]()
    var differentMeals = [String]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        ref = FIRDatabase.database().reference()
        
        //get the day of the week
      //  ref?.child("cormet").observeSingleEvent(of: .value, with: { (snapshot) in
        
           // let dictionary = snapshot.value as? NSDictionary
           // print (dictionary)
            //self.daysOfTheWeek = dictionary?.allKeys as! [String]
         //   print(self.daysOfTheWeek)
        
       // })
        print("kijken wat er precies print")
        print(self.daysOfTheWeek)
        self.tableViewImage.reloadData()
        
        

        // Do any additional setup after loading the view.
    }


    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weekCell", for: indexPath) as! WeekTableViewCell
        
        cell.weekLabel.text = daysOfTheWeek[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(daysOfTheWeek.count)
        return daysOfTheWeek.count
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        self.ref?.child("cormet").child(daysOfTheWeek[indexPath.row]).observeSingleEvent(of: .value, with: { (snapshot) in
            let meals = snapshot.value as? NSDictionary
            
            self.kindOfMeals = meals?.allKeys as! [String]
            
            for key in self.daysOfTheWeek{
                self.ref?.child("cormet").child(self.daysOfTheWeek[indexPath.row]).child(key).observeSingleEvent(of: .value, with: { (snapshot) in
                    let nameMeals = snapshot.value as? NSDictionary
                    
                    self.differentMeals = nameMeals?.allKeys as! [String]
                    for names in self.differentMeals{
                        
                        self.ref?.child("cormet").child(self.daysOfTheWeek[indexPath.row]).child(key).child(names).child("likes").observeSingleEvent(of: .value, with: {(snapshot) in
                            if let likesName = snapshot.value as? String{
                                self.numberOflikes.append(likesName)
                                print (self.numberOflikes)
                            }
                        })
                        self.ref?.child("cormet").child(self.daysOfTheWeek[indexPath.row]).child(key).child(names).child("name").observeSingleEvent(of: .value, with: {(snapshot) in
                            if let mealsName = snapshot.value as? String{
                                self.nameDish.append(mealsName)
                            }
                        })
                        self.ref?.child("cormet").child(self.daysOfTheWeek[indexPath.row]).child(key).child(names).child("price").observeSingleEvent(of: .value, with: {(snapshot) in
                            if let pricesName = snapshot.value as? String{
                                self.prices.append(pricesName)
                            }
                        })
                        
                        
                    }
                })
                
            }
        })
    self.performSegue(withIdentifier: "mealsVC", sender: nil)
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mealsVC"{
            
            let controller = segue.destination as! TodayMealsViewController,
            index = self.tableViewImage.indexPathForSelectedRow?.row
            print (self.nameDish)
            //controller.meal = [self.nameDish[index!]]
            //controller.likes = [self.numberOflikes[index!]]
            //controller.prices = [self.prices[index!]]
        }
        
    }

}

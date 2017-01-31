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
    
    var ref: FIRDatabaseReference?
    var databaseHandle: FIRDatabaseHandle?
    var day = String()
    let color = UIColor(red: 121.0/255.0, green: 172.0/255.0, blue: 43.0/255.0, alpha: 1.0)
    
    let types = ["Soup", "Sandwich", "Hot dish"]
    
    var listAllNames = [[String]]()
    var listCategoryname = [String]()
    var listOfMeals = [meals]()

    
    
    override func viewDidLoad() {
        getMeals()
        super.viewDidLoad()
        nameDay.text = day
        print(day)
        
        
        ref = FIRDatabase.database().reference()
        

        self.tableViewImage.reloadData()
        
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
        var returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 25))
    
        returnedView = makeSectionHeader(returnedView: returnedView, section: section, listAllNames: self.listAllNames)
        
        return returnedView
    }
    
    
    //MARK: reference to my own github
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let mealcell = tableView.dequeueReusableCell(withIdentifier: "mealCell", for: indexPath) as! MealsTodayTableViewCell

            mealcell.likeButton.isHidden = true
            mealcell.unlikeButton.isHidden = true
        for meal in listOfMeals{
            

            if meal.name == listAllNames[indexPath.section][indexPath.row+1]{
                mealcell.nameMeal.text = meal.name
                mealcell.priceMeal.text = "€ \(meal.price!)"
                mealcell.numberOfLikes.text = " \(meal.likes!) likes"
                mealcell.day = day
                mealcell.typeMealLiked = meal.typeOFMEal
                
                if meal.likes != 0 {
                    for person in meal.peopleWhoLike{
                        if person == FIRAuth.auth()!.currentUser!.uid{
                            mealcell.unlikeButton.isHidden = false
                            mealcell.likeButton.isHidden = true
                            }
                        else{
                            mealcell.likeButton.isHidden = false
                            mealcell.unlikeButton.isHidden = true
                        }
                        }
                
                } else{
                    mealcell.unlikeButton.isHidden = true
                    mealcell.likeButton.isHidden = false
                    }
            }
        }
        
        return mealcell
    
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    //MARK: Get meals from firebase
    func getMeals(){
        
               
        let ref = FIRDatabase.database().reference()
        
        ref.child("cormet").child("different days").child(day).queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
            
            (self.listAllNames, self.listOfMeals) = self.getMealInformation(snapshot: snapshot, categories: self.types, kindOfCategorie: "type")
            
            self.tableViewImage.reloadData()

        })
    }
    
}


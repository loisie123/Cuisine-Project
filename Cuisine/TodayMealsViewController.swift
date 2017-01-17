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

    
    var ref: FIRDatabaseReference?
    var databaseHandle: FIRDatabaseHandle?
    var meal = [String]()
    var prices = [String]()
    var likes = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    ref = FIRDatabase.database().reference()
    let user = FIRAuth.auth()?.currentUser?.uid
        
    self.tableViewImage.reloadData()
        
        print ("show table view")
        // Do any additional setup after loading the view.
    }
    



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print ("hoi")
        print (meal.count)
        return meal.count
    }

    
    
    //MARK: reference to my own github
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mealcell = tableView.dequeueReusableCell(withIdentifier: "mealCell", for: indexPath) as! MealsTodayTableViewCell
        print(meal[indexPath.row])
        mealcell.nameMeal.text = meal[indexPath.row]
        mealcell.numberOfLikes.text = likes[indexPath.row]
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
}

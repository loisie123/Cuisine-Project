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
    
    
    var days = [String]()
    var selectedDay = String()
    var array = [String]()
    
    
    
    override func viewDidLoad() {
        getweek()
        super.viewDidLoad()
        
        if days.isEmpty{
            days = ["No information available"]
        }
        
        ref = FIRDatabase.database().reference()
        self.tableViewImage.reloadData()

        }
    
    
    //MARK:- Get the available dates.
    func getweek(){
        let ref = FIRDatabase.database().reference()
        ref.child("cormet").child("different days").observeSingleEvent(of: .value, with: { (snapshot) in
            
            self.days = self.getWeekDays(snapshot: snapshot)
            self.tableViewImage.reloadData()
            
        })
    }

    //MARK:- Make tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weekCell", for: indexPath) as! WeekTableViewCell
        
        cell.weekLabel.text = days[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            selectedDay = days[indexPath.row]
        
            self.performSegue(withIdentifier: "mealsVC", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mealsVC"{
            
            let controller = segue.destination as! TodayMealsViewController
                        controller.day = selectedDay
        }
        
    }

}

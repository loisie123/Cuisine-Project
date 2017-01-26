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
    var selectedDay = String()
    
    
    
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
       
        self.tableViewImage.reloadData()
        
        

        // Do any additional setup after loading the view.
    }


    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weekCell", for: indexPath) as! WeekTableViewCell
        
        cell.weekLabel.text = daysOfTheWeek[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysOfTheWeek.count
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            selectedDay = daysOfTheWeek[indexPath.row]
        
            self.performSegue(withIdentifier: "mealsVC", sender: nil)
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mealsVC"{
            
            let controller = segue.destination as! TodayMealsViewController
                        controller.day = selectedDay
         
           
        }
        
    }

}

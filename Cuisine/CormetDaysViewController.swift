//
//  CormetDaysViewController.swift
//  Cuisine
//
//  Created by Lois van Vliet on 26-01-17.
//  Copyright © 2017 Lois van Vliet. All rights reserved.
//

import UIKit
import Firebase

class CormetDaysViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var weekNumberTableViewImage: UITableView!

    var ref:FIRDatabaseReference?
    var databaseHandle: FIRDatabaseHandle?
    
    var selectedDay = String()
    var days = [String]()
    var array = [String]()
    
    override func viewDidLoad() {
        getweek()
       
        super.viewDidLoad()

        if days.isEmpty{
            days = ["Add new days"]
        }
        ref = FIRDatabase.database().reference()
        self.weekNumberTableViewImage.reloadData()
    }

    func getweek(){
        let ref = FIRDatabase.database().reference()
        ref.child("cormet").child("different days").observeSingleEvent(of: .value, with: { (snapshot) in
            let dictionary = snapshot.value as? NSDictionary
            self.array = dictionary?.allKeys as! [String]
            
            self.days = self.array.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
            self.weekNumberTableViewImage.reloadData()
            
        })
        
    }
    
    
    
    
    
    // building a table View
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "daysCell", for: indexPath) as! CormetDaysTableViewCell
        
        cell.nameDays.text = days[indexPath.row]
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return days.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedDay = days[indexPath.row]
        self.performSegue(withIdentifier: "daysVC", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let alertController = UIAlertController(title: "Delete", message: "Do you really want to delete this day?", preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelAction = UIAlertAction(title: "No", style: .default)
            
            let deleteAction = UIAlertAction(title: "Yes", style: .default) {action in
            
                let remove = self.days[indexPath.row]
                
                self.myDeleteFunction(firstTree: "cormet", secondTree: "different days", childIWantToRemove: remove)
                 self.viewDidLoad()
            }
            
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            
            self.present(alertController, animated: true, completion: nil)

        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    // prepare when a row is selected
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "daysVC"{
            let controller = segue.destination as! CormetDaysMenuViewController
            controller.day = selectedDay
            
        }
    }
    
}





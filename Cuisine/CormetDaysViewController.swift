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

    var daysOfTheWeek = [String]()
    var ref:FIRDatabaseReference?
    var databaseHandle: FIRDatabaseHandle?
    var selectedDay = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        ref = FIRDatabase.database().reference()
        self.weekNumberTableViewImage.reloadData()
        
        print (daysOfTheWeek)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // make tableView
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "daysCell", for: indexPath) as! CormetDaysTableViewCell
        
        cell.nameDays.text = daysOfTheWeek[indexPath.row]
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysOfTheWeek.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDay = daysOfTheWeek[indexPath.row]
        print("ik selecteerd deze ")
        self.performSegue(withIdentifier: "daysVC", sender: nil)
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "daysVC"{
            print("dit doet hij dus niet")
            let controller = segue.destination as! CormetDaysMenuViewController
            controller.day = selectedDay
            
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let remove = daysOfTheWeek[indexPath.row]
            
            myDeleteFunction(firstTree: "cormet", secondTree: "different days", childIWantToRemove: remove)
            
        }
        
        viewDidLoad()
    }
    
    //MARK: delete function. reference: http://stackoverflow.com/questions/39631998/how-to-delete-from-firebase-database
    func myDeleteFunction(firstTree: String, secondTree: String, childIWantToRemove: String) {
        
        
        
        ref?.child(firstTree).child(secondTree).child(childIWantToRemove).removeValue { (error, ref) in
            if error != nil {
                print("error \(error)")
            }
            else{
                print ("removed")
            }
            
            
        }
    }
    
}

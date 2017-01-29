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
    var days = [String]()
    
    
    override func viewDidLoad() {
        getweek()
        super.viewDidLoad()

        
        ref = FIRDatabase.database().reference()
        self.weekNumberTableViewImage.reloadData()
        print ("of is deze eerst ")
        print (daysOfTheWeek)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // make tableView
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "daysCell", for: indexPath) as! CormetDaysTableViewCell
        
        cell.nameDays.text = days[indexPath.row]
        
       // cell.nameDays.text = daysOfTheWeek[indexPath.row]
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //daysOfTheWeek.count
        
        return days.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // selectedDay = daysOfTheWeek[indexPath.row]
        
        selectedDay = days[indexPath.row]
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
            
            let alertController = UIAlertController(title: "Delete", message: "Do you really want to delete this day?", preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .default) {action in
            
                let remove = self.daysOfTheWeek[indexPath.row]
                
                self.myDeleteFunction(firstTree: "cormet", secondTree: "different days", childIWantToRemove: remove)

            
                 self.viewDidLoad()
            }
            
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            
            self.present(alertController, animated: true, completion: nil)

        }
        
       
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
    
    
    func getweek(){
        let ref = FIRDatabase.database().reference()
        
        //get the day of the week
        ref.child("cormet").child("different days").observeSingleEvent(of: .value, with: { (snapshot) in
            let day = week()
            let dictionary = snapshot.value as? NSDictionary
            self.days = dictionary?.allKeys as! [String]
            
            
            print ("wanneer begint dit")
            print(self.days)
            
            self.weekNumberTableViewImage.reloadData()
            
        })

    }
    
}

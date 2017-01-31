//
//  CormetStandardViewController.swift
//  Cuisine
//
//  Created by Lois van Vliet on 24-01-17.
//  Copyright © 2017 Lois van Vliet. All rights reserved.
//

import UIKit
import Firebase

class CormetStandardViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var ref: FIRDatabaseReference?
    var databaseHandle: FIRDatabaseHandle?
    
    
    
    var listAllNames = [[String]]()
    var listCategoryName = [String]()
    var listOfmeals = [meals]()

    @IBOutlet weak var standaardAssortimentTableView: UITableView!
    
    override func viewDidLoad() {
        getStandardAssortiment()
        

        super.viewDidLoad()        
        ref = FIRDatabase.database().reference()
        
        
    }

    func getStandardAssortiment() {
        listAllNames = [[String]]()
        listOfmeals = [meals]()
        
        print ("wanneer gaat hij hier doorheen")

        let ref = FIRDatabase.database().reference()
        let categories = ["Bread", "Dairy", "Drinks", "Fruits", "Salads", "Warm food", "Wraps", "Remaining Categories"]
        
        ref.child("cormet").child("standaard-assortiment").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
            
            (self.listAllNames, self.listOfmeals) = self.getMealInformation(snapshot: snapshot, categories: categories, kindOfCategorie: "categorie")
            self.standaardAssortimentTableView.reloadData()
            
        })
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return listAllNames.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let index = indexPath.row
            let removelist = listAllNames[indexPath.section]
            let remove = removelist[index + 1]
        
            myDeleteFunction(firstTree: "cormet", secondTree: "standaard-assortiment", childIWantToRemove: remove)
        }
        
        viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        returnedView = makeSectionHeader(returnedView: returnedView, section: section, listAllNames: listAllNames)
        
        return returnedView
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listAllNames[section].count-1
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return listAllNames[section][0]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "standaardCell", for: indexPath) as! CormetStandaardTableViewCell
        
        for meal in listOfmeals{
            if meal.name == listAllNames[indexPath.section][indexPath.row+1]{

                cell.nameMeal.text = meal.name
                cell.priceMeal.text = "€ \(meal.price!)"
                cell.likesMeal.text = " \(meal.likes!) likes"
            }
        }
        return cell
    }

    
}

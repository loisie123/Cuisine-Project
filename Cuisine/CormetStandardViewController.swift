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
        if listOfmeals.isEmpty{
                print("hij is nog empty")
        }else{
            standaardAssortimentTableView.reloadData()
        }
        
    }

    func getStandardAssortiment() {
        listAllNames = [[String]]()
        listOfmeals = [meals]()
        
        print ("wanneer gaat hij hier doorheen")

        let ref = FIRDatabase.database().reference()
        
        ref.child("cormet").child("standaard-assortiment").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
            
            self.getMealInformation(snapshot: snapshot)
            
        })
    }
    
    private func getMealInformation(snapshot: FIRDataSnapshot) {
        print("punt 1")
        
        let meal = snapshot.value as! [String:AnyObject]
        listAllNames = [[String]]()
        listOfmeals = [meals]()
        
        let categories = ["Bread", "Dairy", "Drinks", "Fruits", "Salads", "Warm food", "Wraps", "Remaining Categories"]
        
        for category in categories{
            var listCategoryName = [String]()
            listCategoryName.append(category)
            
            print("punt 2")
            for (_,value) in meal{
                
                let showmeals = meals()
                if let cat = value["categorie"] as? String{
                    
                    if cat == category{
                        print("cat is gelijk aan category")
                        if let likes = value["likes"] as? Int, let name = value["name"] as? String, let price = value["price"] as? String{
                            print ("punt 88")
                            listCategoryName.append(name)
                            showmeals.name = name
                            showmeals.price = price
                            showmeals.likes = likes
                            listOfmeals.append(showmeals)
                            print("listofmeals")
                        }
                    }
                }
            }
            print("listCategoryName: \(listCategoryName)")
            listAllNames.append(listCategoryName)
        }
        
        self.standaardAssortimentTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return listAllNames.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 25))
        let color = UIColor(red: 121.0/255.0, green: 172.0/255.0, blue: 43.0/255.0, alpha: 0.7)
        returnedView.backgroundColor = color
        let label = UILabel(frame: CGRect(x: 10, y: 7, width: view.frame.size.width, height: 25))
        label.text = self.listAllNames[section][0]
        label.textColor = .black
        returnedView.addSubview(label)
        
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

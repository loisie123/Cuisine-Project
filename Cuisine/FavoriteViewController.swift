//
//  FavoriteViewController.swift
//  
//
//  Created by Lois van Vliet on 20-01-17.
//
//

import UIKit
import Firebase

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var ref: FIRDatabaseReference?
    var databaseHandle: FIRDatabaseHandle?
    
    let types = ["Soup", "Sandwich", "Hot dish", "standaard-assortiment"]
    var listAllNamesFavorites = [[String]]()
    var listCategorynameFavorites = [String]()
    var listOfMealsFavorites = [meals]()
    
    
    
    @IBOutlet weak var FavoriteTableImage: UITableView!
    
    override func viewDidLoad() {
        getMealsFavorites()
                super.viewDidLoad()
        
        // Define identifier
        let reloadTableView = Notification.Name("reloadTableView")
        
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(FavoriteViewController.reloadTableView), name: reloadTableView, object: nil)
        
        

        ref = FIRDatabase.database().reference()

        
        self.FavoriteTableImage.reloadData()
        // Do any additional setup after loading the view.
    }

    func reloadTableView() {
        getMealsFavorites()
        FavoriteTableImage.reloadData()
        
    }
    
    
    // make tableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listAllNamesFavorites.count
    }
    

   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    return listAllNamesFavorites[section].count-1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       
        return listAllNamesFavorites[section][0]
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 25))
        returnedView = makeSectionHeader(returnedView: returnedView, section: section, listAllNames: self.listAllNamesFavorites)
        
        
        return returnedView
    }


    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoriteTableViewCell
        
        for meal in listOfMealsFavorites{
            if meal.name == listAllNamesFavorites[indexPath.section][indexPath.row+1] {
                cell.nameMeal.text = meal.name
                cell.priceFavoriteMeal.text = "\(meal.price!)"
                cell.likesFavoriteMeal.text = "\(meal.likes!) likes"
                cell.day = meal.day
            }
        }
     return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
    
    func getMealsFavorites(){
    
        
        let currentUser =  FIRAuth.auth()?.currentUser?.uid
        let ref = FIRDatabase.database().reference()
        
        ref.child("users").child(currentUser!).child("likes").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
            
               (self.listAllNamesFavorites, self.listOfMealsFavorites) = self.getMealInformation(snapshot: snapshot, categories: self.types, kindOfCategorie: "type")
            
        
            self.FavoriteTableImage.reloadData()
            })
        }
    
    
    
}

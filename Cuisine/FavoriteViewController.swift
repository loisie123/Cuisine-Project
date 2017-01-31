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
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 25))
        let color = UIColor(red: 121.0/255.0, green: 172.0/255.0, blue: 43.0/255.0, alpha: 1.0)
        returnedView.backgroundColor = color
        let label = UILabel(frame: CGRect(x: 10, y: 7, width: view.frame.size.width, height: 25))
        label.text = self.listAllNamesFavorites[section][0]
        label.textColor = .black

      
        returnedView.addSubview(label)
        
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
        
            let Dish = snapshot.value as! [String: AnyObject]
            self.listAllNamesFavorites = [[String]]()
            self.listOfMealsFavorites = [meals]()
                
            for type in self.types{
                self.listCategorynameFavorites = [String]()
                self.listCategorynameFavorites.append(type)
                for (_, value) in Dish{
                    let mealsToShow = meals()
                    if let typ = value["type"] as? String{
                        if typ == type{
                            if let likes = value["likes"] as? Int, let name = value["name"] as? String, let price = value["price"] as? String{
                                print ("true")
                                self.listCategorynameFavorites.append(name)
                                mealsToShow.name = name
                                mealsToShow.likes = likes
                                mealsToShow.price = price
                                mealsToShow.day = value["day"] as? String
                            
                                self.listOfMealsFavorites.append(mealsToShow)
                                
                            }
                        }
                    }
                }
                self.listAllNamesFavorites.append(self.listCategorynameFavorites)
            }
            self.FavoriteTableImage.reloadData()
            })
        }
    
    
    
}

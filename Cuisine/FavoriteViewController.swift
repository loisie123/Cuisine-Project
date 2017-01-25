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
    var listOfFavorites = [meals]()
    var listOfFAvoriteMealsNamesSoop = ["soup"]
    var listOfFavoriteMealsNameSandwich = ["Sandwich"]
    var listOfFavoriteMealsNameMeals = ["warm eten"]
    var listAllFavoritesNames = [[String]]()
    
    
    @IBOutlet weak var FavoriteTableImage: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define identifier
        let reloadTableView = Notification.Name("reloadTableView")
        
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(FavoriteViewController.reloadTableView), name: reloadTableView, object: nil)

        
        
        ref = FIRDatabase.database().reference()

        getMeals()
        
        self.FavoriteTableImage.reloadData()
        // Do any additional setup after loading the view.
    }

    func reloadTableView() {
        getMeals()
        FavoriteTableImage.reloadData()
    }
    
    
    // make tableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listAllFavoritesNames.count
    }
    
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    return listAllFavoritesNames[section].count-1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return listAllFavoritesNames[section][0]
    }


    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoriteTableViewCell
        
        for meal in listOfFavorites{
            if meal.name == listAllFavoritesNames[indexPath.section][indexPath.row+1] {
                cell.nameMeal.text = meal.name
                cell.priceFavoriteMeal.text = "€ \(meal.price)"
                cell.likesFavoriteMeal.text = meal.amountOfLikes
                cell.day = meal.day
            }
        }
     return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
        
    }
    
    
    func getMeals(){
        listOfFavorites = [meals]()
        listAllFavoritesNames = [[String]]()
        listOfFAvoriteMealsNamesSoop = ["soup"]
        listOfFavoriteMealsNameSandwich = ["Sandwich"]
        listOfFavoriteMealsNameMeals = ["warm eten"]
        
        let currentUser =  FIRAuth.auth()?.currentUser?.uid
        let ref = FIRDatabase.database().reference()
        ref.child("users").child(currentUser!).child("liked").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
            
            let Dish = snapshot.value as! [String: AnyObject]
            for (_, value) in Dish{
                print (value)
                let mealsToShow = meals()
                if let type = value["type"] as? String{
                    print (type)
                    print (value["type"])
                    
                    if type == "soop"{
                        
                        print ("true")
                        if let likes = value["liked"] as? String, let name = value["name"] as? String, let price = value["price"] as? String{
                            print("true")
                            
                            
                            self.listOfFAvoriteMealsNamesSoop.append(name)
                            mealsToShow.name = name
                            mealsToShow.amountOfLikes = likes
                            mealsToShow.price = price
                            mealsToShow.day = value["day"] as? String
                            
                        
                            self.listOfFavorites.append(mealsToShow)
                            
                            }
                        else {print ("false")}
                        }
                    else if type == "sandwich"{
                        
                        if let likes = value["liked"] as? String, let name = value["name"] as? String, let price = value["price"] as? String{
                            print("true")
                            
                            
                            
                            self.listOfFavoriteMealsNameSandwich.append(name)
                            mealsToShow.name = name
                            mealsToShow.amountOfLikes = likes
                            mealsToShow.price = price
                            mealsToShow.day = value["day"] as? String

                            
                            self.listOfFavorites.append(mealsToShow)
                            
                        }
                    }
                    else if type == "dinner"{
                        
                        if let likes = value["liked"] as? String, let name = value["name"] as? String, let price = value["price"] as? String{
                            print("true")
                            
                            
                            
                            self.listOfFavoriteMealsNameMeals.append(name)
                            mealsToShow.name = name
                            mealsToShow.amountOfLikes = likes
                            mealsToShow.price = price
                            mealsToShow.day = value["day"] as? String

                            
                            self.listOfFavorites.append(mealsToShow)
                            
                        }
                    }
            }
                
                
            self.listAllFavoritesNames = [self.listOfFAvoriteMealsNamesSoop, self.listOfFavoriteMealsNameSandwich, self.listOfFavoriteMealsNameMeals]
    
            self.FavoriteTableImage.reloadData()
            }
        })
        
        ref.removeAllObservers()
        
        
    }
    
    
    
    
    
    


}

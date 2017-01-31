//
//  FavoriteTableViewCell.swift
//  Cuisine
//
//  Created by Lois van Vliet on 20-01-17.
//  Copyright © 2017 Lois van Vliet. All rights reserved.
//

import UIKit
import Firebase

class FavoriteTableViewCell: UITableViewCell {

    
    
    
    @IBOutlet weak var nameMeal: UILabel!
    @IBOutlet weak var priceFavoriteMeal: UILabel!
    @IBOutlet weak var UnlikeButton: UIButton!
    
    @IBOutlet weak var likesFavoriteMeal: UILabel!
    
    var day = String()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
        
    
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //MARK: Unlike a dish that is in favorites.
    @IBAction func UnlikePressedFavorites(_ sender: Any) {
        
        // bij unliken, verwijderen uit favorites van de user
        let ref = FIRDatabase.database().reference()
        let currentUser =  FIRAuth.auth()?.currentUser?.uid
        
        
        // Removed from  the liked list from the user
        let remove = self.nameMeal.text
        print (remove!)
        self.myDeleteFunction(firstTree: currentUser!, secondTree: "likes", childIWantToRemove: remove!)

        // verwijderen van een like
        ref.child("cormet").child("different days").child(self.day).child(self.nameMeal.text!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let properties = snapshot.value as? [String : AnyObject]{
                if let peopleWhoLike = properties["peoplewholike"] as? [String : AnyObject]{
                    for(id, person) in peopleWhoLike{
                        if person as? String == FIRAuth.auth()!.currentUser!.uid{
                            
                            // verwijder persoon uit deze lijst.
                            ref.child("cormet").child("different days").child(self.day).child(self.nameMeal.text!).child("peoplewholike").child(id).removeValue(completionBlock: {(error,reff) in
                                
                                if error == nil{
                                    ref.child("cormet").child("different days").child(self.day).child(self.nameMeal.text!).observeSingleEvent(of: .value, with: {(snap) in
             
                                        if let prop = snap.value as? [String: AnyObject] {
                                           
                                            if let likes = prop["peoplewholike"] as? [String : AnyObject] {
                                               
                                                let count = likes.count
                                                ref.child("cormet").child("different days").child(self.day).child(self.nameMeal.text!).updateChildValues(["likes" : count])
                                                
                                            } else{
                                                ref.child("cormet").child("different days").child(self.day).child(self.nameMeal.text!).updateChildValues(["likes" : 0])
                                            }
                                            
                                        }
                                    })
                                }
                            })
                        }
                    }
                }
            }
        })
        ref.removeAllObservers()
        
        let reloadTableView = Notification.Name("reloadTableView")
        NotificationCenter.default.post(name: reloadTableView, object: nil)
    }
    


    
    //MARK: delete function. reference: http://stackoverflow.com/questions/39631998/how-to-delete-from-firebase-database
    func myDeleteFunction(firstTree: String, secondTree: String, childIWantToRemove: String) {
        let ref = FIRDatabase.database().reference()
        
        ref.child("users").child(firstTree).child(secondTree).child(childIWantToRemove).removeValue { (error, ref) in
            if error != nil {
                print("error \(error)")
            }
            else{
                print ("removed")
            }
            
            
        }
    }

    
    
}


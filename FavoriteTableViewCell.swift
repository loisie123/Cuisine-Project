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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //MARK:- Unlike a dish that is in favorites and update the dish.
    @IBAction func UnlikePressedFavorites(_ sender: Any) {
        
        // bij unliken, verwijderen uit favorites van de user
        let ref = FIRDatabase.database().reference()
        let currentUser =  FIRAuth.auth()?.currentUser?.uid
        let remove = self.nameMeal.text
        self.myDeleteFunction(firstTree: currentUser!, secondTree: "likes", childIWantToRemove: remove!)
        
        
        // In This case the dish is saved under Standard-assortiment
        if self.day == "Standard Assortment"{
            
            let keyToPostStandard = ref.child("cormet").child("Standard Assortment").child(remove!)
            
            unlikePost(keyToPost: keyToPostStandard)
            ref.removeAllObservers()
            
            let reloadTableView = Notification.Name("reloadTableView")
            NotificationCenter.default.post(name: reloadTableView, object: nil)
        }
        // In this case the dish was is saved under: different days.
        else{
            let keyToPostDays = ref.child("cormet").child("different days").child(self.day).child(remove!)
            
            unlikePost(keyToPost: keyToPostDays)
            ref.removeAllObservers()
            
            let reloadTableView = Notification.Name("reloadTableView")
            NotificationCenter.default.post(name: reloadTableView, object: nil)
        }
    }

    
    
    // MARK: - Function that unlikes an dish when someone clicks on the hart. 
    // Reference: https://www.youtube.com/watch?v=AIN_bbIku_o
    
    func unlikePost(keyToPost: AnyObject){
        
        keyToPost.observeSingleEvent(of: .value, with: { (snapshot) in
            if let properties = snapshot.value as? [String : AnyObject]{
                
                if let peopleWhoLike = properties["peoplewholike"] as? [String : AnyObject]{
                    
                    for(id, person) in peopleWhoLike{
                        if person as? String == FIRAuth.auth()!.currentUser!.uid{
                            
                            // Delete id from list of id's that like that particular dish 
                            // Ans update amount of total likes
                            keyToPost.child("peoplewholike").child(id).removeValue(completionBlock: {(error,reff) in
                                if error == nil{
                                    keyToPost.observeSingleEvent(of: .value, with: {(snap) in
                                        
                                        if let prop = snap.value as? [String: AnyObject] {
                                            if let likes = prop["peoplewholike"] as? [String : AnyObject] {
                            
                                                let count = likes.count
                                                keyToPost.updateChildValues(["likes" : count])
                                                
                                            } else{
                                                keyToPost.updateChildValues(["likes" : 0])
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
    }
}


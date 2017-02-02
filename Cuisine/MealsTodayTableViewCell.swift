//
//  MealsTodayTableViewCell.swift
//  Cuisine
//
//  Created by Lois van Vliet on 15-01-17.
//  Copyright © 2017 Lois van Vliet. All rights reserved.
//

import UIKit
import Firebase

class MealsTodayTableViewCell: UITableViewCell {
    
    @IBOutlet weak var numberOfLikes: UILabel!
    @IBOutlet weak var unlikeButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var priceMeal: UILabel!
    @IBOutlet weak var nameMeal: UILabel!
    
    
    var day: String!
    var typeMealLiked: String!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //MARK:- Like function
    // reference: https://www.youtube.com/watch?v=AIN_bbIku_o
    @IBAction func likePressed(_ sender: Any) {
       
        let ref = FIRDatabase.database().reference()
        let keytoPost = ref.child("cormet").child("different days").child(self.day).child(self.nameMeal.text!).childByAutoId().key
        
        
        ref.child("cormet").child("different days").child(self.day).child(self.nameMeal.text!).observeSingleEvent(of: .value, with: {(snapshot) in
            
            if (snapshot.value as? [String : AnyObject]) != nil{
                
                let updateLikes: [String : Any] = ["peoplewholike/\(keytoPost)" : FIRAuth.auth()!.currentUser!.uid]
                ref.child("cormet").child("different days").child(self.day).child(self.nameMeal.text!).updateChildValues(updateLikes, withCompletionBlock: {(error, reff) in
    
                    if error == nil{
                        
                        let keyToLike =  ref.child("cormet").child("different days").child(self.day).child(self.nameMeal.text!)
                     
                        self.updateLabelsAndButtonsLiked(key: keyToLike)
                            
                        }
                })
            }
        })
        ref.removeAllObservers()
    }
    
    
    // function that upedates the labels and buttons
    func  updateLabelsAndButtonsLiked(key: AnyObject){
        
        key.observeSingleEvent(of: .value, with: { (snap) in
            let user =  FIRAuth.auth()?.currentUser?.uid
            
            if let properties = snap.value as? [String : AnyObject] {
                if let likes = properties["peoplewholike"] as? [String : AnyObject]{
                    let count = likes.count
                    
                    self.numberOfLikes.text = "\(count) likes"
                    let update = ["likes" : count]
                    key.updateChildValues(update)
                    
                    self.likeButton.isHidden = true
                    self.unlikeButton.isHidden = false
                    self.saveMeal(user: user!, name: self.nameMeal.text!, price: self.priceMeal.text!, count: count, type: self.typeMealLiked, day: self.day, child: "different days")
                    
                }
            }
        })
    }
    
    //MARK:- function that unlikes the different dishes. 
    // reference: https://www.youtube.com/watch?v=AIN_bbIku_o
    @IBAction func unlikeButtonPressed(_ sender: Any) {
 
        let ref = FIRDatabase.database().reference()
        let currentUser =  FIRAuth.auth()?.currentUser?.uid
        let remove = self.nameMeal.text
        self.myDeleteFunction(firstTree: currentUser!, secondTree: "likes", childIWantToRemove: remove!)
        
        ref.child("cormet").child("different days").child(self.day).child(self.nameMeal.text!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let properties = snapshot.value as? [String : AnyObject]{
                
                if let peopleWhoLike = properties["peoplewholike"] as? [String : AnyObject]{
    

                    for(id, person) in peopleWhoLike{
                        print (person)
                        if person as? String == FIRAuth.auth()!.currentUser!.uid{
                            ref.child("cormet").child("different days").child(self.day).child(self.nameMeal.text!).child("peoplewholike").child(id).removeValue(completionBlock: {(error,reff) in
                                if error == nil{
                                    
                                  let keyToUnlike = ref.ref.child("cormet").child("different days").child(self.day).child(self.nameMeal.text!)
                                    
                                   
                                    self.updateLikesAndButtosDislikes(key: keyToUnlike)
        
                                }
                            })
                        }
                    }
                }
            }
        })
        ref.removeAllObservers()
    }
    
    // Function that upedates the labels and buttons
    func updateLikesAndButtosDislikes(key: AnyObject){
        
        key.observeSingleEvent(of: .value, with: {(snap) in
            if let prop = snap.value as? [String: AnyObject] {
                if let likes = prop["peoplewholike"] as? [String : AnyObject] {
                    
                    let count = likes.count
                    self.numberOfLikes.text = "\(count) likes"
                    
                    key.updateChildValues(["likes" : count])
                    
                } else{
                    self.numberOfLikes.text = "\(0) likes"
                    key.updateChildValues(["likes" : 0])
                }
                self.likeButton.isHidden = false
                self.unlikeButton.isHidden = true
                
            }
        })
    }
    
}


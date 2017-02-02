//
//  UserStandardTableViewCell.swift
//  Cuisine
//
//  Created by Lois van Vliet on 25-01-17.
//  Copyright © 2017 Lois van Vliet. All rights reserved.
//

import UIKit
import Firebase

class UserStandardTableViewCell: UITableViewCell {
    @IBOutlet weak var likeButton: UIButton!

    @IBOutlet weak var unlikeButton: UIButton!
    
    
    @IBOutlet weak var likedLabel: UILabel!
    
  
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
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

    
    
    //MARK:- unlike fuction for standard Assortiment.
    @IBAction func unlikePressed(_ sender: Any) {
        
        let ref = FIRDatabase.database().reference()
        let currentUser =  FIRAuth.auth()?.currentUser?.uid
        let remove = self.nameLabel.text
        self.myDeleteFunction(firstTree: currentUser!, secondTree: "likes", childIWantToRemove: remove!)
        
        // likes most be updated.
        ref.child("cormet").child("Standard Assortment").child(self.nameLabel.text!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let properties = snapshot.value as? [String : AnyObject]{
                if let peopleWhoLike = properties["peoplewholike"] as? [String : AnyObject]{
                    for(id, person) in peopleWhoLike{
                        if person as? String == FIRAuth.auth()!.currentUser!.uid{
                            ref.child("cormet").child("Standard Assortment").child(self.nameLabel.text!).child("peoplewholike").child(id).removeValue(completionBlock: {(error,reff) in
                                if error == nil{
                                    ref.child("cormet").child("Standard Assortment").child(self.nameLabel.text!).observeSingleEvent(of: .value, with: {(snap) in
                                       
                                            self.updateLikesAndButtosDislikes(snapshot: snap)
                                        
                                    })
                                }
                            })
                        }
                    }
                }
            }
        })
        ref.removeAllObservers()
    
    }
    
    
    func updateLikesAndButtosDislikes(snapshot: FIRDataSnapshot){
        
        let ref = FIRDatabase.database().reference()

         if let prop = snapshot.value as? [String: AnyObject] {
        if let likes = prop["peoplewholike"] as? [String : AnyObject] {
            
            let count = likes.count
            self.likedLabel.text = "\(count) likes"
            
            ref.child("cormet").child("Standard Assortment").child(self.nameLabel.text!).updateChildValues(["likes" : count])
            
            } else{
                self.likedLabel.text = "0 likes"
                    ref.child("cormet").child("Standard Assortment").child(self.nameLabel.text!).updateChildValues(["likes" : 0])
        }
        self.likeButton.isHidden = false
        self.unlikeButton.isHidden = true
        }
    }
    
    
    //MARK:- like function
    @IBAction func likePressed(_ sender: Any) {
        
        let ref = FIRDatabase.database().reference()
        
        let keytoPost = ref.child("cormet").child("Standard Assortment").child(self.nameLabel.text!).childByAutoId().key
        
        ref.child("cormet").child("Standard Assortment").child(self.nameLabel.text!).observeSingleEvent(of: .value, with: {(snapshot) in
            
            if (snapshot.value as? [String : AnyObject]) != nil{
                let updateLikes: [String : Any] = ["peoplewholike/\(keytoPost)" : FIRAuth.auth()!.currentUser!.uid]
                
                ref.child("cormet").child("Standard Assortment").child(self.nameLabel.text!).updateChildValues(updateLikes, withCompletionBlock: {(error, reff) in
                    
                    if error == nil{
                        
                        ref.child("cormet").child("Standard Assortment").child(self.nameLabel.text!).observeSingleEvent(of: .value, with: { (snap) in
                            
                            
                            self.updateLabelsAndButtonsLiked(snapshot: snap)
                            
                  
                        })
                    }
                })
                
            }
            
        })
        ref.removeAllObservers()
    }
    

    func  updateLabelsAndButtonsLiked(snapshot: FIRDataSnapshot){
        let ref = FIRDatabase.database().reference()
        let user =  FIRAuth.auth()?.currentUser?.uid
        if let properties = snapshot.value as? [String : AnyObject] {
            if let likes = properties["peoplewholike"] as? [String : AnyObject]{
                let count = likes.count
                
                self.likedLabel.text = "\(count) likes"
                let update = ["likes" : count]
                ref.child("cormet").child("Standard Assortment").child(self.nameLabel.text!).updateChildValues(update)
            
                self.likeButton.isHidden = true
                self.unlikeButton.isHidden = false
        
                
                saveMeal(user: user!, name: self.nameLabel.text!, price: self.priceLabel.text!, count: count, type: "Standard Assortment", day: "Standard Assortment", child: "Standard Assortment")
   
            }
        }
    }

}






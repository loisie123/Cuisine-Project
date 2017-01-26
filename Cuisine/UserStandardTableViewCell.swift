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
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    
    @IBAction func unlikePressed(_ sender: Any) {
        
        self.unlikeButton.isEnabled = true
        
        let ref = FIRDatabase.database().reference()
        let currentUser =  FIRAuth.auth()?.currentUser?.uid
        
        
        // Removed from  the liked list from the user
        let remove = self.nameLabel.text
        print (remove!)
        self.myDeleteFunction(firstTree: currentUser!, secondTree: "likes", childIWantToRemove: remove!)
        
        // likes most be updated.
        
        ref.child("cormet").child("standaard-assortiment").child(self.nameLabel.text!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let properties = snapshot.value as? [String : AnyObject]{
                print ("properties : \(properties)")
                
                if let peopleWhoLike = properties["peoplewholike"] as? [String : AnyObject]{
                    print (peopleWhoLike)
                    
                    for(id, person) in peopleWhoLike{
                        print (person)
                        if person as? String == FIRAuth.auth()!.currentUser!.uid{
                            ref.child("cormet").child("standaard-assortiment").child(self.nameLabel.text!).child("peoplewholike").child(id).removeValue(completionBlock: {(error,reff) in
                                if error == nil{
                                    
                                    ref.child("cormet").child("standaard-assortiment").child(self.nameLabel.text!).observeSingleEvent(of: .value, with: {(snap) in
                                        if let prop = snap.value as? [String: AnyObject] {
                                            if let likes = prop["peoplewholike"] as? [String : AnyObject] {
                                                
                                                let count = likes.count
                                                self.likedLabel.text = "\(count) likes"
                                                
                                                ref.child("cormet").child("standaard-assortiment").child(self.nameLabel.text!).updateChildValues(["likes" : count])
                                                
                                            } else{
                                                self.likedLabel.text = "0 likes"
                                                ref.child("cormet").child("standaard-assortiment").child(self.nameLabel.text!).updateChildValues(["likes" : 0])
                                            }
                                            self.likeButton.isHidden = false
                                            self.unlikeButton.isHidden = true
                                            self.unlikeButton.isEnabled = false
                                            
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
    
    }
    
    
    
    
    @IBAction func likePressed(_ sender: Any) {
        
        self.likeButton.isEnabled = true
        
        let user =  FIRAuth.auth()?.currentUser?.uid
        
        let ref = FIRDatabase.database().reference()
        
        let keytoPost = ref.child("cormet").child("standaard-assortiment").child(self.nameLabel.text!).childByAutoId().key
        ref.child("cormet").child("standaard-assortiment").child(self.nameLabel.text!).observeSingleEvent(of: .value, with: {(snapshot) in
            
            if let meal = snapshot.value as? [String : AnyObject]{
                let updateLikes: [String : Any] = ["peoplewholike/\(keytoPost)" : FIRAuth.auth()!.currentUser!.uid]
                ref.child("cormet").child("standaard-assortiment").child(self.nameLabel.text!).updateChildValues(updateLikes, withCompletionBlock: {(error, reff) in
                    if error == nil{
                        ref.child("cormet").child("standaard-assortiment").child(self.nameLabel.text!).observeSingleEvent(of: .value, with: { (snap) in
                            if let properties = snap.value as? [String : AnyObject] {
                                if let likes = properties["peoplewholike"] as? [String : AnyObject]{
                                    let count = likes.count
                            
                                    self.likedLabel.text = "\(count) likes"
                                    let update = ["likes" : count]
                                    ref.child("cormet").child("standaard-assortiment").child(self.nameLabel.text!).updateChildValues(update)
                                    self.likeButton.isHidden = true
                                    self.unlikeButton.isHidden = false
                                    self.likeButton.isEnabled = false
                                    
                                    
                                    // slaat hij op in het likes van de gebruiker
                                    ref.child("users").child(user!).child("likes").child(self.nameLabel.text!).child("name").setValue(self.nameLabel.text!)
                                    ref.child("users").child(user!).child("likes").child(self.nameLabel.text!).child("price").setValue(self.priceLabel.text!)
                                    ref.child("users").child(user!).child("likes").child(self.nameLabel.text!).child("likes").setValue(count)
                                    ref.child("users").child(user!).child("likes").child(self.nameLabel.text!).child("day").setValue("standaard-assortiment")
                                    ref.child("users").child(user!).child("likes").child(self.nameLabel.text!).child("type").setValue("standaard-assortiment")
                                    
                                    
                                }
                            }
                        })
                    }
                })
                
            }
            
        })
        ref.removeAllObservers()
        
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

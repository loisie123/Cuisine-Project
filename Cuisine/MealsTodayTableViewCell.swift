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

    
    @IBAction func likePressed(_ sender: Any) {
        self.likeButton.isEnabled = true
        
        let user =  FIRAuth.auth()?.currentUser?.uid
        
        let ref = FIRDatabase.database().reference()
        
      
        let keytoPost = ref.child("cormet").child("different days").child(self.day).child(self.nameMeal.text!).childByAutoId().key
        ref.child("cormet").child("different days").child(self.day).child(self.nameMeal.text!).observeSingleEvent(of: .value, with: {(snapshot) in
            
            if let meal = snapshot.value as? [String : AnyObject]{
                print ("meal is \(meal)")
                let updateLikes: [String : Any] = ["peoplewholike/\(keytoPost)" : FIRAuth.auth()!.currentUser!.uid]
                ref.child("cormet").child("different days").child(self.day).child(self.nameMeal.text!).updateChildValues(updateLikes, withCompletionBlock: {(error, reff) in
                    if error == nil{
                        ref.child("cormet").child("different days").child(self.day).child(self.nameMeal.text!).observeSingleEvent(of: .value, with: { (snap) in
                            if let properties = snap.value as? [String : AnyObject] {
                                if let likes = properties["peoplewholike"] as? [String : AnyObject]{
                                  let count = likes.count
                                    
                                    
                                    self.numberOfLikes.text = "\(count) likes"
                                    let update = ["likes" : count]
                                    
                                    ref.child("cormet").child("different days").child(self.day).child(self.nameMeal.text!).updateChildValues(update)
                                    self.likeButton.isHidden = true
                                    self.unlikeButton.isHidden = false
                                    self.likeButton.isEnabled = false
        
                                    
                                    // slaat hij op in het likes van de gebruiker
                                    self.saveMeal(user: user!, name: self.nameMeal.text!, price: self.priceMeal.text!, count: count, type: self.typeMealLiked)
                            
                                    
                                }
                            }
                        })
                    }
                })
                
            }
            
        })
        ref.removeAllObservers()
    }
    
    
    @IBAction func unlikeButtonPressed(_ sender: Any) {
        self.unlikeButton.isEnabled = true
        let ref = FIRDatabase.database().reference()
        let currentUser =  FIRAuth.auth()?.currentUser?.uid
        
        
        // Removed from  the liked list from the user
        let remove = self.nameMeal.text
        print (remove!)
        self.myDeleteFunction(firstTree: currentUser!, secondTree: "likes", childIWantToRemove: remove!)
        
        // likes most be updated.
        
        ref.child("cormet").child("different days").child(self.day).child(self.nameMeal.text!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let properties = snapshot.value as? [String : AnyObject]{
               print ("properties : \(properties)")
                
                if let peopleWhoLike = properties["peoplewholike"] as? [String : AnyObject]{
                    print (peopleWhoLike)

                    for(id, person) in peopleWhoLike{
                        print (person)
                        if person as? String == FIRAuth.auth()!.currentUser!.uid{
                            ref.child("cormet").child("different days").child(self.day).child(self.nameMeal.text!).child("peoplewholike").child(id).removeValue(completionBlock: {(error,reff) in
                                if error == nil{
                                    
                                    print ("Waar zal die stoppen")
                                    ref.child("cormet").child("different days").child(self.day).child(self.nameMeal.text!).observeSingleEvent(of: .value, with: {(snap) in
                                        if let prop = snap.value as? [String: AnyObject] {
                                            print ("is prop goed")
                                            print (prop)
                                            if let likes = prop["peoplewholike"] as? [String : AnyObject] {
                                                
                                                
                                                print (" niks ")
                                                print("worden de likes geupdate?")
                                                let count = likes.count
                                                self.numberOfLikes.text = "\(count) likes"
                                                
                                                ref.child("cormet").child("different days").child(self.day).child(self.nameMeal.text!).updateChildValues(["likes" : count])
                                                
                                            } else{
                                                self.numberOfLikes.text = "\(0) likes"
                                                ref.child("cormet").child("different days").child(self.day).child(self.nameMeal.text!).updateChildValues(["likes" : 0])
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
    
    func saveMeal(user: String, name: String, price: String, count: Int, type: String){
        
        let ref = FIRDatabase.database().reference()
        
        ref.child("users").child(user).child("likes").child(name).child("name").setValue(name)
        ref.child("users").child(user).child("likes").child(name).child("price").setValue(price)
        ref.child("users").child(user).child("likes").child(name).child("likes").setValue(count)
        ref.child("users").child(user).child("likes").child(name).child("day").setValue(day)
        ref.child("users").child(user).child("likes").child(name).child("type").setValue(type)
        
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

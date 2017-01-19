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
    
    var postID: String!
    var day: String!
    var nameMealPost: String!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func likePressed(_ sender: Any) {
        self.likeButton.isHidden = false
        self.unlikeButton.isHidden = true
       
        let ref = FIRDatabase.database().reference()
        let keytoPost = ref.child("cormet").child(self.day).child(self.nameMealPost).childByAutoId().key
        ref.child("cormet").child(self.day).child(self.nameMealPost).observeSingleEvent(of: .value, with: {(snapshot) in
            
            if let meal = snapshot.value as? [String : AnyObject]{
                print ("meal is \(meal)")
                let updateLikes: [String : Any] = ["peoplewholike/\(keytoPost)" : FIRAuth.auth()!.currentUser!.uid]
                ref.child("cormet").child(self.day).child(self.nameMealPost).updateChildValues(updateLikes, withCompletionBlock: {(error, reff) in
                    if error == nil{
                        ref.child("cormet").child(self.day).child(self.nameMealPost).observeSingleEvent(of: .value, with: { (snap) in
                            if let properties = snap.value as? [String : AnyObject] {
                                if let likes = properties["peoplewholike"] as? [String : AnyObject]{
                                  let count = likes.count
                                    print("werkt het?")
                                    self.numberOfLikes.text = "\(count)"
                                    let update = ["likes " : count]
                                    ref.child("cormet").child(self.day).child(self.nameMealPost).updateChildValues(update)
                                    self.likeButton.isHidden = true
                                    self.unlikeButton.isHidden = false
                                    self.likeButton.isEnabled = true
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
        
        self.unlikeButton.isEnabled = false
        let ref = FIRDatabase.database().reference()
        
        ref.child("cormet").child(self.day).child(self.nameMealPost).observeSingleEvent(of: .value, with: { (snapshot) in
            if let properties = snapshot.value as? [String : AnyObject]{
                print ("properties : \(properties)")
                if let peopleWhoLike = properties["peoplewholike"] as? [String : AnyObject]{
                    print (peopleWhoLike)
                    
                    for(id, person) in peopleWhoLike{
                        print (person)
                        if person as? String == FIRAuth.auth()!.currentUser!.uid{
                            ref.child("cormet").child(self.day).child(self.nameMealPost).child("peoplewholike").child(id).removeValue(completionBlock: {(error,reff) in
                                if error != nil{
                                    ref.child("cormet").child(self.day).child(self.nameMealPost).observeSingleEvent(of: .value, with: {(snap) in
                                        if let prop = snap.value as? [String: AnyObject] {
                                            if let likes = prop["peoplewholike"] as? [String : AnyObject] {
                                                let count = likes.count
                                                self.numberOfLikes.text = "\(count)"
                                                ref.child("cormet").child(self.day).child(self.nameMealPost).updateChildValues(["likes" : count])
                                            } else{
                                                self.numberOfLikes.text = "0"
                                                ref.child("posts").child(self.postID).updateChildValues(["likes" : 0])
                                            }
                                        }
                                    })
                                }
                            })
                            
                            self.likeButton.isHidden = false
                            self.unlikeButton.isHidden = true
                            self.unlikeButton.isEnabled = true
                            break
                        }
                    }
                }
            }
        })
        ref.removeAllObservers()
    }
    


}

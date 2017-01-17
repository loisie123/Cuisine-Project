//
//  UsersViewController.swift
//  Cuisine
//
//  Created by Lois van Vliet on 16-01-17.
//  Copyright © 2017 Lois van Vliet. All rights reserved.
//

import UIKit
import Firebase

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewImage: UITableView!
    
    var listOfUsers = [users]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUsers()

        // Do any additional setup after loading the view.
    }


    func getUsers(){
        let ref = FIRDatabase.database().reference()
        ref.child("users").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
          
            let Users = snapshot.value as! [String: AnyObject]
            
            for (_, value) in Users{
                if let uid = value["uid"] as? String{
                    if uid != FIRAuth.auth()!.currentUser!.uid{
                        let userToShow = users()
                        if let name = value["name"] as? String, let imagePath = value["urlToImage"] as? String{
                            userToShow.name = name
                            userToShow.imagePath = imagePath
                            userToShow.userID = uid
                            self.listOfUsers.append(userToShow)
                            print ("wat gebeurd hier")
                            print (userToShow.name)
                            print (userToShow.imagePath)
                        }
                        
                    }
                }
            }
            self.tableViewImage.reloadData()
            
        })
        ref.removeAllObservers()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listOfUsers.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "usersCell", for: indexPath) as! UsersTableViewCell
        
        cell.imageUser.download(from: self.listOfUsers[indexPath.row].imagePath!)
        cell.usersName.text = self.listOfUsers[indexPath.row].name!
        print("hebben we dan eindelijk iets")
        print (self.listOfUsers[indexPath.row].name!)
        
        return cell
    }
    

}

extension UIImageView{
    func download(from imgURL: String!){
        let url = URLRequest(url: URL(string: imgURL)!)
        
        
        let task = URLSession.shared.dataTask(with: url){
            (data, response, error) in

            if error != nil {
                print(error!)
                return
        
            }

         DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        
        task.resume()
        
    }
}

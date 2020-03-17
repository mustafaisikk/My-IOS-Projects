//
//  FeedViewController.swift
//  instagramClone
//
//  Created by Mustafa IŞIK on 11.03.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var useremailArray = [String]()
    var userCommendArray = [String]()
    var likeArray =  [Int]()
    var userImageArray =  [String]()
    var documentIdArray =  [String]()
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        getDataFromFirestore()
    }
    
    func getDataFromFirestore(){
        
         let fireStoreDatabase = Firestore.firestore()
        /*
         let firestoreSettings = fireStoreDatabase.settings
         firestoreSettings.areTimestampsInSnapshotsEnabled = true
         fireStoreDatabase.settings = firestore
        */
        fireStoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
            if error != nil{
                print(error?.localizedDescription ?? "Error")
            }
            else{
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                    
                     self.userCommendArray.removeAll(keepingCapacity: false)
                     self.userImageArray.removeAll(keepingCapacity: false)
                     self.useremailArray.removeAll(keepingCapacity: false)
                     self.likeArray.removeAll(keepingCapacity: false)
                     self.documentIdArray.removeAll(keepingCapacity: false)
                    
                    
                    for document in snapshot!.documents{
                        let documentId = document.documentID
                        self.documentIdArray.append(documentId)
                        if let postedBy = document.get("postedBy") as? String{
                            self.useremailArray.append(postedBy)
                        }
                        if let postComment = document.get("postComment") as? String{
                            self.userCommendArray.append(postComment)
                        }
                        if let likes = document.get("likes") as? Int{
                            self.likeArray.append(likes)
                        }
                        if let imageUrl = document.get("imageUrl") as? String{
                            self.userImageArray.append(imageUrl)
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return useremailArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.userEmailLabel.text = useremailArray [indexPath.row]
        cell.userCommendLabel.text = userCommendArray [indexPath.row]
        cell.userImageView.sd_setImage(with: URL(string: self.userImageArray [indexPath.row]))
        cell.documentIdLabel.text = documentIdArray [indexPath.row]
        cell.likeLabel.text = String(likeArray[indexPath.row])
        return cell
    }
    
}

//
//  FeedCell.swift
//  instagramClone
//
//  Created by Mustafa IŞIK on 11.03.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit
import Firebase
class FeedCell: UITableViewCell {

    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userCommendLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var documentIdLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let docRef = Firestore.firestore().collection("Likes").document("\(Auth.auth().currentUser!.uid)\(self.documentIdLabel.text!)")
        docRef.getDocument { (document, error) in
            if let _ = document, document!.exists{
                //print("\(Auth.auth().currentUser!.uid)\(self.documentIdLabel.text!)")
                self.likeButton.setTitle("Dislike", for: UIControl.State.normal)
            }
        }
        // Configure the view for the selected state
    }
    @IBAction func likeButtonClicked(_ sender: UIButton) {
        
        if let likeCount = Int(likeLabel.text!){
            
            let whichPost =  ["likedBy" : String(Auth.auth().currentUser!.uid),"postId" : documentIdLabel.text!] as  [String : Any]
            
            let docRef = Firestore.firestore().collection("Likes").document("\(Auth.auth().currentUser!.uid)\(self.documentIdLabel.text!)")
            docRef.getDocument { (document, error) in
                if let _ = document, document!.exists{
                    docRef.delete(){ err in
                        if let err = err {
                            print("Error removing document: \(err)")
                        } else {
                            let likeStore = ["likes" : likeCount - 1] as   [String : Any]
                            Firestore.firestore().collection("Posts").document(self.documentIdLabel.text!).setData(likeStore, merge: true)
                            self.likeButton.setTitle("LIKE", for: UIControl.State.normal)
                        }
                    }
                }
                else{
                    Firestore.firestore().collection("Likes").document("\(Auth.auth().currentUser!.uid)\(self.documentIdLabel.text!)").setData(whichPost, merge: true)
                    let likeStore = ["likes" : likeCount + 1] as   [String : Any]
                    Firestore.firestore().collection("Posts").document(self.documentIdLabel.text!).setData(likeStore, merge: true)
                    self.likeButton.setTitle("Dislike", for: UIControl.State.normal)
                }
            }
        }
        
    }
}

//
//  RequestsCellTableViewCell.swift
//  ForsquereClone
//
//  Created by Mustafa IŞIK on 23.03.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit
import Parse

class RequestCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var takeBackBtn: UIButton!
    @IBOutlet weak var declineBtn: UIButton!
    
    var userId = ""
    var userNAme = ""
    var currentUserId = PFUser.current()?.objectId! ?? ""
    var currentUserName = PFUser.current()?.username
    var tabbarcontroller = UITabBarController()
    var tableViewCell = UITableView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.tableViewCell.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func acceptButton(_ sender: UIButton) {
        
        let requestQuery = PFQuery(className: "Requests")
        requestQuery.whereKey("senderId", equalTo: self.userId)
        requestQuery.whereKey("receiverId", equalTo: self.currentUserId)
        requestQuery.findObjectsInBackground { (objects, error) in
            if error == nil {
                if objects != nil {
                    for object in objects! {
                        object.deleteEventually()
                    }
                }
            }
        }
        
        let SenderQuery = PFQuery(className: "Requests")
        SenderQuery.whereKey("senderId", equalTo: self.currentUserId)
        SenderQuery.whereKey("receiverId", equalTo: self.userId)
        SenderQuery.findObjectsInBackground { (objects, error) in
            if error == nil {
                if objects != nil {
                    for object in objects! {
                        object.deleteEventually()
                    }
                }
            }
        }
        
        let createFriendsObject = PFObject(className: "Friends")
        createFriendsObject["currentId"] = self.currentUserId
        createFriendsObject["friendsId"] = self.userId
        createFriendsObject["currentName"] = self.currentUserName
        createFriendsObject["friendsName"] = self.userNAme
        createFriendsObject.saveInBackground { (succes, error) in
            if error == nil {
                let createFriendsObject = PFObject(className: "Friends")
                createFriendsObject["currentId"] = self.userId
                createFriendsObject["friendsId"] = self.currentUserId
                createFriendsObject["currentName"] = self.userNAme
                createFriendsObject["friendsName"] = self.currentUserName
                createFriendsObject.saveInBackground { (succes, error) in
                    if error == nil {
                        self.tabbarcontroller.selectedIndex = 1
                    }
                }
            }
        }
        
    }
    @IBAction func declineButton(_ sender: UIButton) {
        let requestQuery = PFQuery(className: "Requests")
        requestQuery.whereKey("senderId", equalTo: self.userId)
        requestQuery.whereKey("receiverId", equalTo: self.currentUserId)
        requestQuery.findObjectsInBackground { (objects, error) in
            if error == nil {
                if objects != nil {
                    for object in objects! {
                        object.deleteEventually()
                    }
                }
            }
        }
        
        let SenderQuery = PFQuery(className: "Requests")
        SenderQuery.whereKey("senderId", equalTo: self.currentUserId)
        SenderQuery.whereKey("receiverId", equalTo: self.userId)
        SenderQuery.findObjectsInBackground { (objects, error) in
            if error == nil {
                if objects != nil {
                    for object in objects! {
                        object.deleteEventually()
                    }
                }
            }
        }

        self.tabbarcontroller.selectedIndex = 1
    }
    
    @IBAction func takeBackButton(_ sender: UIButton) {
        let requestQuery = PFQuery(className: "Requests")
        requestQuery.whereKey("senderId", equalTo: self.currentUserId)
        requestQuery.whereKey("receiverId", equalTo: self.userId)
        requestQuery.findObjectsInBackground { (objects, error) in
            if error == nil {
                if objects != nil {
                    for object in objects! {
                        object.deleteEventually()
                    }
                }
            }
        }
        
        let SenderQuery = PFQuery(className: "Requests")
        SenderQuery.whereKey("senderId", equalTo: self.userId)
        SenderQuery.whereKey("receiverId", equalTo: self.currentUserId)
        SenderQuery.findObjectsInBackground { (objects, error) in
            if error == nil {
                if objects != nil {
                    for object in objects! {
                        object.deleteEventually()
                    }
                }
            }
        }
        self.tabbarcontroller.selectedIndex = 1
    }
    
}

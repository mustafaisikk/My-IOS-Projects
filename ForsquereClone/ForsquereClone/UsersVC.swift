//
//  UsersVC.swift
//  ForsquereClone
//
//  Created by Mustafa IŞIK on 23.03.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit
import Parse

class UsersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var tableView: UITableView!
    
    var nameArray = [String]()
    var idArray = [String]()
    var currentUserId = ""
    var currentUserName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        currentUserId = PFUser.current()?.objectId! ?? ""
        currentUserName = PFUser.current()?.username! ?? ""
        getDataFromParse()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Sending Request", message: "Request is sent to \(nameArray[indexPath.row])", preferredStyle: UIAlertController.Style.alert)
        let sendRequst = UIAlertAction(title: "Send", style: UIAlertAction.Style.default) { (SendAction) in
            //self.sendRequest(receiverId: self.idArray[indexPath.row])
            self.friendsControl(receiverId: self.idArray[indexPath.row], receiverUserName: self.nameArray[indexPath.row])
            
        }
        let dontSendRequest = UIAlertAction(title: "Dont`t Send", style: UIAlertAction.Style.destructive, handler: nil)
        
        alert.addAction(sendRequst)
        alert.addAction(dontSendRequest)
        self.present(alert, animated: true, completion: nil)
        
        //print(idArray[indexPath.row])
    }
    
    func friendsControl(receiverId : String, receiverUserName : String){
        let friendsControlQuery = PFQuery(className: "Friends")
        friendsControlQuery.whereKey("currentId", equalTo: self.currentUserId)
        friendsControlQuery.whereKey("friendsId", equalTo: receiverId)
        friendsControlQuery.findObjectsInBackground { (objects, error) in
            if error != nil {
                self.makeAllert(titleInput: "Error", messageInput: error?.localizedDescription ?? "")
            }else{
                if objects != nil {
                    if objects!.count > 0 {
                        self.makeAllert(titleInput: "Remind", messageInput: "You are already friends with \(receiverUserName)")
                        return
                    }
                    self.requestControl(receiverId: receiverId, receiverUserName: receiverUserName)
                }
            }
        }
    }
    
    func requestControl(receiverId : String, receiverUserName : String){
        
        let controlQuery = PFQuery(className: "Requests")
        controlQuery.whereKey("senderId", equalTo: currentUserId)
        controlQuery.whereKey("receiverId", equalTo: receiverId)
        controlQuery.findObjectsInBackground { (objects, error) in
            if error != nil {
                self.makeAllert(titleInput: "Error", messageInput: error?.localizedDescription ?? "")
            }else{
                if objects != nil {
                    if objects!.count > 0 {
                        self.makeAllert(titleInput: "Remind", messageInput: "Request Was Sent Before")
                        return
                    }
                    self.sendRequest(receiverId: receiverId, receiverUserName: receiverUserName)
                }
            }
        }
    }
    
    func sendRequest(receiverId : String , receiverUserName : String){
        let requestObject = PFObject(className: "Requests")
        requestObject["senderId"] = currentUserId
        requestObject["senderUserName"] = currentUserName
        requestObject["receiverId"] = receiverId
        requestObject["receiverUserName"] = receiverUserName
        requestObject.saveInBackground { (succes, error) in
            if error != nil {
                let alert = UIAlertController(title: "error", message: error?.localizedDescription ?? "Error", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else{
                
                self.makeAllert(titleInput: "Yes", messageInput: "Request sent")
            }
        }
    }
    
    func getDataFromParse(){
        
        let userQuery = PFUser.query()
        
        userQuery?.whereKeyExists("username")
        
        userQuery?.findObjectsInBackground(block: { (objects, error) in
            if error != nil{
                self.makeAllert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
            }else{
                 self.nameArray.removeAll(keepingCapacity: false)
                 self.idArray.removeAll(keepingCapacity: false)
                 if objects != nil{
                     for object in objects! {
                         if let userName = object.object(forKey: "username") as? String {
                             if let userId = object.objectId {
                                if userId != self.currentUserId {
                                    self.nameArray.append(userName)
                                    self.idArray.append(userId)
                                }
                             }
                         }
                     }
                     self.tableView.reloadData()
                 }
            }
        })
    }
    
    func makeAllert(titleInput : String, messageInput : String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

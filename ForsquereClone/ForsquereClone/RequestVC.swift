//
//  RequestVC.swift
//  ForsquereClone
//
//  Created by Mustafa IŞIK on 23.03.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit
import Parse

class RequestVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

    @IBOutlet weak var tableView: UITableView!
    var idArray = [String]()
    var nameArray = [String]()
    var currentIsWho = [String]()
    var currentUserId = PFUser.current()?.objectId! ?? ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        getDataFromParse()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idArray.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDataFromParse()
    }
    
    @objc func getDataFromParse(){
        let currentUserId = PFUser.current()?.objectId! ?? ""
        let requestQuery = PFQuery(className: "Requests")
        requestQuery.findObjectsInBackground { (objects, error) in
            if error != nil {
                self.makeAllert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
            }else{
                self.idArray.removeAll(keepingCapacity: false)
                self.currentIsWho.removeAll(keepingCapacity: false)
                self.nameArray.removeAll(keepingCapacity: false)
                
                if objects != nil {
                    for object in objects! {
                        if let senderId = object.object(forKey: "senderId") as? String {
                            if let senderUserName = object.object(forKey: "senderUserName") as? String {
                                if let receiverId = object.object(forKey: "receiverId") as? String {
                                    if let receiverUserName = object.object(forKey: "receiverUserName") as? String {
                                        if senderId == currentUserId {
                                            self.currentIsWho.append("sender")
                                            self.idArray.append(receiverId)
                                            self.nameArray.append(receiverUserName)
                                        }
                                        else if receiverId == currentUserId {
                                            self.currentIsWho.append("receiver")
                                            self.idArray.append(senderId)
                                            self.nameArray.append(senderUserName)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
       
    func makeAllert(titleInput : String, messageInput : String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let requestCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RequestCell
        requestCell.userNAme = nameArray[indexPath.row]
        requestCell.userId = idArray[indexPath.row]
        requestCell.tabbarcontroller = self.tabBarController!
        requestCell.tableViewCell = self.tableView
        if currentIsWho[indexPath.row] == "sender" {
            requestCell.takeBackBtn.isHidden = false
            requestCell.acceptBtn.isHidden = true
            requestCell.declineBtn.isHidden = true
            requestCell.userNameLabel.text = "You Sent a Request to \(nameArray[indexPath.row])"
        }else if currentIsWho[indexPath.row] == "receiver" {
            requestCell.acceptBtn.isHidden = false
            requestCell.declineBtn.isHidden = false
            requestCell.takeBackBtn.isHidden = true
            requestCell.userNameLabel.text = "\(nameArray[indexPath.row]) Sent You a Request"
        }
        return requestCell
    }
}

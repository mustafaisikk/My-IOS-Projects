//
//  MyFriendsVC.swift
//  ForsquereClone
//
//  Created by Mustafa IŞIK on 23.03.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit
import Parse
class MyFriendsVC: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var nameArray = [String]()
    var idArray  = [String]()
    var selectedId = ""
    var currentUserId = PFUser.current()?.objectId! ?? ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "NEW", style: UIBarButtonItem.Style.plain, target: self, action: #selector(gotoUsersVC))
        
        getMyFriendsFromParse()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        selectedId = idArray[indexPath.row]
        self.performSegue(withIdentifier: "myFriedsPlacesDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "myFriedsPlacesDetails" {
            let friendsDestinationVC = segue.destination as? FriendsPlacesVC
            friendsDestinationVC?.choosenFriendsId = selectedId
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getMyFriendsFromParse()
    }
    
    func getMyFriendsFromParse(){
        let myFriendsQuery = PFQuery(className: "Friends")
        myFriendsQuery.whereKey("currentId", equalTo: self.currentUserId)
        myFriendsQuery.findObjectsInBackground { (objects, error) in
            if error != nil {
                self.makeAllert(titleInput: "Error", messageInput: error?.localizedDescription ?? "")
            }else {
                self.nameArray.removeAll(keepingCapacity: false)
                self.idArray.removeAll(keepingCapacity: false)
                
                if objects != nil {
                    for object in objects! {
                        if let friendsId = object.object(forKey: "friendsId") as? String {
                            if let friendsName = object.object(forKey: "friendsName") as? String {
                                self.idArray.append(friendsId)
                                self.nameArray.append(friendsName)
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Are You Sure?", message: "Your Friends Is Being Deleted", preferredStyle: UIAlertController.Style.alert)
            let yesButton = UIAlertAction(title: "YES", style: UIAlertAction.Style.default) { (action) in
                self.deleteMyFriends(friendsId: self.idArray[indexPath.row])
            }
            let declineButton = UIAlertAction(title: "GIVE UP", style: UIAlertAction.Style.destructive, handler: nil)
            alert.addAction(yesButton)
            alert.addAction(declineButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func deleteMyFriends(friendsId : String){
        let deleteMyFriensQuery = PFQuery(className: "Friends")
        deleteMyFriensQuery.whereKey("currentId", equalTo: self.currentUserId)
        deleteMyFriensQuery.whereKey("friendsId", equalTo: friendsId)
        deleteMyFriensQuery.findObjectsInBackground { (objects, error) in
            if error != nil {
                self.makeAllert(titleInput: "Error", messageInput: error?.localizedDescription ?? "")
            }else{
                if objects != nil {
                    for object in objects! {
                        object.deleteEventually()
                    }
                }
            }
        }
        let deleteMyFriendsQuery2 = PFQuery(className: "Friends")
        deleteMyFriendsQuery2.whereKey("currentId", equalTo: friendsId)
        deleteMyFriendsQuery2.whereKey("friendsId", equalTo: self.currentUserId)
        deleteMyFriendsQuery2.findObjectsInBackground { (objects, error) in
            if error != nil {
                self.makeAllert(titleInput: "Error", messageInput: error?.localizedDescription ?? "")
            }else{
                if objects != nil {
                    for object in objects! {
                        object.deleteEventually()
                    }
                }
            }
        }
        self.performSegue(withIdentifier: "deleteMyFriends", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.nameArray[indexPath.row]
        return cell
    }
    @objc func gotoUsersVC(){
        self.performSegue(withIdentifier: "gotoUsersVC", sender: nil)
    }
    func makeAllert(titleInput : String, messageInput : String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }

}

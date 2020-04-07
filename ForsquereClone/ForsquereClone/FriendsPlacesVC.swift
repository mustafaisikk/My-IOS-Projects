//
//  FriendsPlacesDetailsVC.swift
//  ForsquereClone
//
//  Created by Mustafa IŞIK on 1.04.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit
import Parse
class FriendsPlacesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var choosenFriendsId = ""
    var nameArray = [String]()
    var idArray = [String]()
    var selectedPlacesId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        getFriendsPlaces()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFriendsPlacesDetails" {
            let friendsPlacesDestinationVC = segue.destination as? FriendsPlacesDetailsVC
            friendsPlacesDestinationVC?.choosenId = self.selectedPlacesId
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        selectedPlacesId = self.idArray[indexPath.row]
        self.performSegue(withIdentifier: "toFriendsPlacesDetails", sender: nil)
    }
    
    func getFriendsPlaces(){
        let friendsPlacesQuery = PFQuery(className: "Places")
        friendsPlacesQuery.whereKey("userId", equalTo: self.choosenFriendsId)
        friendsPlacesQuery.findObjectsInBackground { (objects, error) in
            if error != nil {
                self.makeAllert(titleInput: "Error", messageInput: error?.localizedDescription ?? "")
            }else {
                self.idArray.removeAll(keepingCapacity: false)
                self.nameArray.removeAll(keepingCapacity: false)
                
                if objects != nil {
                    for object in objects! {
                        if let friendsPlacesId = object.objectId {
                            if let friendsPlacesName = object.object(forKey: "name") as? String {
                                self.idArray.append(friendsPlacesId)
                                self.nameArray.append(friendsPlacesName)
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }
    func makeAllert(titleInput : String, messageInput : String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}


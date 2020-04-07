//
//  PlacesVC.swift
//  ForsquereClone
//
//  Created by Mustafa IŞIK on 18.03.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit
import Parse

class PlacesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

    @IBOutlet weak var tableView: UITableView!
    var nameArray =  [String]()
    var idArray = [String]()
    var selectedID = ""
    var currentUserId = PFUser.current()?.objectId! ?? ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = 	UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: UIBarButtonItem.Style.done, target: self, action: #selector(logOutButtonClicked))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromParse()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDataFromParse()
    }
    
    func getDataFromParse(){
        
        let query = PFQuery(className: "Places")
        query.whereKey("userId", equalTo: self.currentUserId)
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                self.makeAllert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
            }else{
                
                self.nameArray.removeAll(keepingCapacity: false)
                self.idArray.removeAll(keepingCapacity: false)
                
                if objects != nil{
                    for object in objects! {
                        if let placeName = object.object(forKey: "name") as? String {
                            if let placeID = object.objectId {
                                self.nameArray.append(placeName)
                                self.idArray.append(placeID)
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "toDetails" {
             let destinationVC = segue.destination as? DetailsVC
             destinationVC?.choosenId = selectedID
         }
     }
     
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedID = idArray [indexPath.row]
        self.performSegue(withIdentifier: "toDetails", sender: nil)
    }
    
    @objc func addButtonClicked(){
        self.performSegue(withIdentifier: "toAddPlaceVC", sender: nil)
    }
    @objc func logOutButtonClicked(){
        PFUser.logOutInBackground { (error) in
            if error != nil{
                self.makeAllert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
            }else{
                self.performSegue(withIdentifier: "toSignUpVC", sender: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Are You Sure?", message: "Deleting This Place...", preferredStyle: UIAlertController.Style.alert)
            let yesButton = UIAlertAction(title: "YES", style: UIAlertAction.Style.default) { (action) in
                self.deleteMyPlace(placeId: self.idArray[indexPath.row])
            }
            let declineButton = UIAlertAction(title: "GIVE UP", style: UIAlertAction.Style.destructive, handler: nil)
            alert.addAction(yesButton)
            alert.addAction(declineButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func deleteMyPlace(placeId : String){
        let deletePlaceQuery = PFQuery(className: "Places")
        deletePlaceQuery.whereKey("objectId", equalTo: placeId)
        deletePlaceQuery.findObjectsInBackground { (objects, error) in
            if error != nil {
                self.makeAllert(titleInput: "Error", messageInput: error?.localizedDescription ?? "")
            }else{
                if objects != nil {
                    objects![0].deleteEventually()
                    self.performSegue(withIdentifier: "reloadMyPlaces", sender: nil)
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
}

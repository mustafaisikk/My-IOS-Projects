//
//  ViewController.swift
//  birthdayNotTaker
//
//  Created by Mustafa IŞIK on 29.02.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var friendsName: UITextField!
    @IBOutlet weak var friendsBirdhDay: UITextField!
    @IBOutlet weak var labelFriendsName: UILabel!
    @IBOutlet weak var labelFriendsBirthDay: UILabel!
    
    let storedName = UserDefaults.standard.object(forKey: "friendsName")
    let storedBirthDay = UserDefaults.standard.object(forKey: "friendsBirthDay")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let oldName = storedName as? String {
            labelFriendsName.text = "Friends Name : " + oldName
        }
        
        if let oldBirthDay = storedBirthDay as? String {
            labelFriendsBirthDay.text = "Friends Birth Day : " + oldBirthDay
        }

    }

    
    @IBAction func buttonSave(_ sender: UIButton) {
        
        UserDefaults.standard.set(friendsName.text, forKey: "friendsName")
        UserDefaults.standard.set(friendsBirdhDay.text, forKey: "friendsBirthDay")
        
        labelFriendsName.text = "Friends Name : " + friendsName.text!
        labelFriendsBirthDay.text = "Friends Birth Day : " + friendsBirdhDay.text!
        
        friendsName.text = ""
        friendsBirdhDay.text = ""
    }
    
    @IBAction func buttonDelete(_ sender: UIButton) {
        
        if (storedName as? String) != nil {
            UserDefaults.standard.removeObject(forKey: "friendsName")
            labelFriendsName.text = "Friends Name : "
        }
        
        if (storedBirthDay as? String) != nil {
            UserDefaults.standard.removeObject(forKey: "friendsBirthDay")
            labelFriendsBirthDay.text = "Friends Birth Day : "
        }
    }
    
}


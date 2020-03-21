//
//  ViewController.swift
//  ForsquereClone
//
//  Created by Mustafa IŞIK on 18.03.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit
import Parse

class SignUpVC: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInClicked(_ sender: UIButton) {
        if userNameField.text != "" && passwordField.text != ""{
            PFUser.logInWithUsername(inBackground: userNameField.text!, password: passwordField.text!) { (user, error) in
                if error != nil{
                    self.makeAllert(titleInput: "Error", messageInput: error!.localizedDescription)
                }else{
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
        }else{
            makeAllert(titleInput: "Error", messageInput: "Email or Password cannot be empty")
        }
        
    }
    
    
    @IBAction func signUpClicked(_ sender: UIButton) {
        
        if self.userNameField.text != "" && self.passwordField.text != "" {
            
             let user = PFUser()
             user.username = self.userNameField.text
             user.password = self.passwordField.text
             user.signUpInBackground { (succes, error) in
                 if error != nil{
                     self.makeAllert(titleInput: "Error", messageInput: error!.localizedDescription)
                 }else{
                     self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                 }
             }
             
        }else{
            makeAllert(titleInput: "Error", messageInput: "Email or Password cannot be empty")
        }
        
    }
    
    
    func makeAllert(titleInput : String, messageInput : String){
        
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}


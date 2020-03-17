//
//  ViewController.swift
//  instagramClone
//
//  Created by Mustafa IŞIK on 11.03.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the 
    }
    
    @IBAction func signInClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != ""{
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (authData, error) in
                if error != nil{
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error!")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else{
            makeAlert(titleInput: "Error!", messageInput: "email or password cannot be empty")
        }
        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != ""{
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authData, error) in
                if error != nil{
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error!")
                }else{
                    let firestoreDatabase = Firestore.firestore()
                    /*
                     var firestoreReferance : DocumentReference? = nil
                     let fireStoreUserCreate =  ["userEmail" : self.emailText.text!, "userImage" : "", "UserStatus" : ""]
                     firestoreReferance = firestoreDatabase.collection("Users").addDocument(data: fireStoreUserCreate, completion:  {(error) in
                         if error != nil{
                             self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error" )
                         }
                         else{
                             
                         }
                     })
                     */
                    firestoreDatabase.collection("Users").document(String(Auth.auth().currentUser!.uid) ).setData([
                        "userEmail" : self.emailText.text!, "userImage" : "", "UserStatus" : ""
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                        }
                    }
                    
                }
            }
        }else{
            makeAlert(titleInput: "Error!", messageInput: "email or password cannot be empty")
        }
        
        
    }
    
    func makeAlert(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}


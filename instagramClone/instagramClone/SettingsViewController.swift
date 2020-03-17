//
//  SettingsViewController.swift
//  instagramClone
//
//  Created by Mustafa IŞIK on 11.03.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//
import UIKit
import Firebase
import SDWebImage

class SettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var settingsLAbel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var statusField: UITextField!
    @IBOutlet weak var emailSettingsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImageFunc))
        imageView.addGestureRecognizer(imageTapRecognizer)
        emailSettingsLabel.text = Auth.auth().currentUser?.email
        let fireStoreDatabase = Firestore.firestore()
        let docRef = fireStoreDatabase.collection("Users").document(String(Auth.auth().currentUser?.uid ?? "Error"))
        docRef.getDocument { (document, error) in
            if let documentControl = document, document!.exists{
                if let userImageControl = documentControl.get("userImage") as? String{
                    self.imageView.sd_setImage(with: URL(string: userImageControl))
                }
                if let userStatusControl = documentControl.get("UserStatus") as? String{
                    self.statusField.text = userStatusControl
                }
            }
        }
        
    }
    @objc func selectImageFunc(){
    
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info [.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateButton(_ sender: UIButton) {
        
        let mediaFolder = Storage.storage().reference().child("UsersPP")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            let imageReferance = mediaFolder.child("\(String(Auth.auth().currentUser!.uid)).jpeg")
            imageReferance.putData(data, metadata: nil){(metadata, error) in
                if error != nil{
                    self.makeAlert(titileString: "Error!", messageString: error?.localizedDescription ?? "Error")
                }
                else{
                    imageReferance.downloadURL { (url, error) in
                        if error == nil{
                            let imageUrl = url?.absoluteString
                            let firestoreDatabase = Firestore.firestore()
                            firestoreDatabase.collection("Users").document(String(Auth.auth().currentUser!.uid) ).setData([
                               "userEmail" : String((Auth.auth().currentUser?.email)!), "userImage" : imageUrl!, "UserStatus" : self.statusField.text!
                            ]) { err in
                                if let err = err {
                                    print("Error writing document: \(err)")
                                } else {
                                    self.tabBarController?.selectedIndex = 0
                                }
                            }
                            
                        }
                    }
                }
                
            }
        }
        
         
    }
    
    func makeAlert(titileString : String, messageString: String){
        let alert = UIAlertController(title: titileString, message: messageString, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func logOutAction(_ sender: UIButton) {
    
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewController", sender: nil)
        } catch {
            print("Error!!!")
        }
    }
}

//
//  UploadViewController.swift
//  instagramClone
//
//  Created by Mustafa IŞIK on 11.03.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var selectImage: UIImageView!
    @IBOutlet weak var commandField: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        selectImage.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImageFunc))
        selectImage.addGestureRecognizer(imageTapRecognizer)
        uploadButton.isEnabled = false
    }
    
    @objc func selectImageFunc(){
        uploadButton.isEnabled = true
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectImage.image = info [.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    func makeAlert(titileString : String, messageString: String){
        let alert = UIAlertController(title: titileString, message: messageString, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        let mediaFolder = storageReferance.child("media")
        
        if let data = selectImage.image?.jpegData(compressionQuality: 0.5){
            let uuid = UUID().uuidString
            let imageReferance = mediaFolder.child("\(uuid).jpeg")
            imageReferance.putData(data, metadata: nil){(metadata, error) in
                if error != nil{
                    self.makeAlert(titileString: "Error!", messageString: error?.localizedDescription ?? "Error")
                }else{
                    imageReferance.downloadURL { (url, error) in
                        if error == nil{
                            let imageurl = url?.absoluteString
                            
                            //DATABASE
                            
                            let fireStoreDatabase = Firestore.firestore()
                            var fireStoreReferance : DocumentReference? = nil
                            let fireStorePost =  ["imageUrl" : imageurl!, "postedBy" : Auth.auth().currentUser!.email, "postComment" : self.commandField.text!,
                                                  "date" : FieldValue.serverTimestamp() , "likes" : 0] as [String : Any]
                            fireStoreReferance = fireStoreDatabase.collection("Posts").addDocument(data: fireStorePost, completion: {(error) in
                                if error != nil{
                                    self.makeAlert(titileString: "Error!", messageString: error?.localizedDescription ?? "Error" )
                                }else{
                                    self.selectImage.image = UIImage(named: "select")
                                    self.commandField.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                        }
                    }
                }
            }
        }
    }
    
}

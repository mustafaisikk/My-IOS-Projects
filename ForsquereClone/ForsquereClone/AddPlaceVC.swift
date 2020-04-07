//
//  AddPlaceVC.swift
//  ForsquereClone
//
//  Created by Mustafa IŞIK on 19.03.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit

class AddPlaceVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var placeNameField: UITextField!
    @IBOutlet weak var placeTypeField: UITextField!
    @IBOutlet weak var placeCommentField: UITextField!
    @IBOutlet weak var placeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        placeImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        placeImageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func chooseImage(){
        
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImageView.image = info [.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        
        
        if placeNameField.text != "" && placeTypeField.text != "" && placeCommentField.text != ""{
            
            if let choosenImage = placeImageView.image{
                let placeModel = PlaceModel.sharedInstance
                placeModel.placeName = placeNameField.text!
                placeModel.placeType = placeTypeField.text!
                placeModel.placeComment = placeCommentField.text!
                placeModel.placeImage = choosenImage
                performSegue(withIdentifier: "toMapVC", sender: nil)
            }else{
                makeAllert(titeInput: "Error", messageInput: "Image Don`t selected")
            }
            
        }else{
            makeAllert(titeInput: "Error", messageInput: "Pleace Don`t Leave Any Space...")
        }
        
        
    }
    
    func makeAllert(titeInput : String, messageInput : String){
        let alert = UIAlertController(title: titeInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

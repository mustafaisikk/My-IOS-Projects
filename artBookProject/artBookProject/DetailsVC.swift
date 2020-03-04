//
//  DetailsVC.swift
//  artBookProject
//
//  Created by Mustafa IŞIK on 4.03.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit
import CoreData

class DetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var iamgeView: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var artistText: UITextField!
    @IBOutlet weak var yearTest: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    
    
    var chosenName = ""
    var choosenId: UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if chosenName != ""{
            
            saveButton.isHidden = true
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            let idString = choosenId?.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                
                if results.count > 0{
                    for result in results as!  [NSManagedObject]{
                        
                        if let name = result.value(forKey: "name") as? String{
                            nameText.text = name
                        }
                        if let artist = result.value(forKey: "artist") as? String{
                            artistText.text = artist
                        }
                        if let year = result.value(forKey: "year") as? Int{
                            yearTest.text = String(year)
                        }
                        if let image = result.value(forKey: "image") as? Data{
                            iamgeView.image = UIImage(data: image)
                        }
                        
                    }
                }
            } catch {
                print("Error")
            }
            
            
        }else{
            saveButton.isHidden = false
            saveButton.isEnabled = false
            nameText.text = ""
            artistText.text = ""
            yearTest.text = ""
        }

        // Do any additional setup after loading the view.
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        iamgeView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        iamgeView.addGestureRecognizer(imageTapRecognizer)
         
    }

    @IBAction func saveButtonClcked(_ sender: Any) {
        
        
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
         let contex = appDelegate.persistentContainer.viewContext
         
         let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: contex)
         
         // Attributes
         
         newPainting.setValue(nameText.text!, forKey: "name")
         newPainting.setValue(artistText.text!, forKey: "artist")
         
         if let year = Int(yearTest.text!){
             newPainting.setValue(year, forKey: "year")
         }
         newPainting.setValue(UUID(), forKey: "id")
         let data = iamgeView.image?.jpegData(compressionQuality: 0.5)
         newPainting.setValue(data, forKey: "image")
         
         do {
             try contex.save()
         } catch  {
             print("Error...")
         }
        NotificationCenter.default.post(name: Notification.Name("newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        iamgeView.image = info[.originalImage] as? UIImage
        saveButton.isEnabled = true
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    @objc func selectImage(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
}

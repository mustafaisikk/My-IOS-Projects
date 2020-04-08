//
//  ViewController.swift
//  MachineLearningImageRecognition
//
//  Created by Mustafa IŞIK on 7.04.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var choosenImage = CIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func changeClicked(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info [.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
        if let ciImage = CIImage(image: imageView.image!) {
            self.choosenImage = ciImage
        }
        
        recogniseImage(image: choosenImage)
        
    }
    
    func recogniseImage(image : CIImage){
        
        self.label.text = "Finding..."
        
        if let model = try? VNCoreMLModel(for: MobileNetV2().model) {
            let request = VNCoreMLRequest(model: model) { (vnRequest, error) in
                if let resutls = vnRequest.results as? [VNClassificationObservation] {
                    if resutls.count > 0 {
                        let topResuts = resutls.first
                        
                        DispatchQueue.main.async {
                            let confidenceLevel = (topResuts?.confidence ?? 0 ) * 100
                            let rounded = Int(confidenceLevel * 100 ) / 100
                            self.label.text = "\(rounded)% it`s \(topResuts!.identifier) "
                        }
                    }
                }
                
            }
            
            let handler = VNImageRequestHandler(ciImage: image)
            DispatchQueue.global(qos: .userInteractive).async {
                do{
                    try handler.perform([request])
                }catch{
                    print("error")
                }
            }
            
        }
    }
    
}


//
//  ViewController.swift
//  gestureRecornizerApp
//
//  Created by Mustafa IŞIK on 29.02.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageView.isUserInteractionEnabled = true
        let gestureRecorgnizer = UITapGestureRecognizer(target: self, action: #selector(changePicture))
        imageView.addGestureRecognizer(gestureRecorgnizer)
    }

    @objc func changePicture(){
        if count == 0{
            imageView.image = UIImage(named: "js.png")
            label.text = "JAVA SCRIPT"
            count = 1
        }else{
            imageView.image = UIImage(named:  "python.jpeg")
            label.text = "PYHTON"
            count = 0
        }
    }

}


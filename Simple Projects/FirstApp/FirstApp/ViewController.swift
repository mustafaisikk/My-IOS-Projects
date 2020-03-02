//
//  ViewController.swift
//  FirstApp
//
//  Created by Mustafa IŞIK on 22.02.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonClicked(_ sender: Any) {
        if count == 0 {
            imageView.image = UIImage(named: "js")
            count = 1
        }
        else{
            imageView.image = UIImage(named: "python")
            count = 0
        }
        
    }
    
}

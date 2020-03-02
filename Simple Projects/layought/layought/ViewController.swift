//
//  ViewController.swift
//  layought
//
//  Created by Mustafa IŞIK on 29.02.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var myLabel = UILabel()
    var counter = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let width = view.frame.size.width
        let height = view.frame.size.height
        
    
        myLabel.text = "Not yet Clicked"
        myLabel.textAlignment = .center
        myLabel.frame = CGRect(x: width * 0.5 - width * 0.8 / 2 , y: height * 0.5 - 50 / 2 , width: width * 0.8, height: 50)
        view.addSubview(myLabel)
        
        let myButton = UIButton()
        myButton.setTitle("Lets Tapped", for: UIControl.State.normal)
        myButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        myButton.frame = CGRect(x: width * 0.5 - 100, y: height * 0.6, width: 200, height: 100)
        view.addSubview(myButton)
        myButton.addTarget(self, action: #selector(ViewController.tapped), for: UIControl.Event.touchUpInside)
    }
    
    @objc func tapped(){
        counter += 1
        myLabel.text = "Clicked " + String(counter) + " Times"
    }


}


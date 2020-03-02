//
//  ViewController.swift
//  timerProject
//
//  Created by Mustafa IŞIK on 29.02.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    var timer = Timer()
    var counter = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timeLabel.text = "Time : " + String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        
    }
    @objc func timerFunc (){
        timeLabel.text = "Time : " + String(counter)
        counter -= 1
        
        if counter == 0 {
            timer.invalidate()
            timeLabel.text = "Time`s Over!"
        }
    }
    @IBAction func buttonClicked(_ sender: Any) {
        print("Tapped")
    }
    

}


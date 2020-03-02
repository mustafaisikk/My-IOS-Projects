//
//  ViewController.swift
//  MyCalculator
//
//  Created by Mustafa IŞIK on 26.02.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var entry1: UITextField!
    @IBOutlet weak var entry2: UITextField!
    @IBOutlet weak var result: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonPlus(_ sender: UIButton) {
        // result.text = String((Int(entry1Text)! * Int(entry2Text)!))
        
        if let _ = Int(entry1.text!), let _ =  Int(entry2.text!){
            result.text = String(Int(entry1.text!)! + Int(entry2.text!)!)
        }
        else{
            result.text = "ERROR!!!"
        }
        
    }
    
    @IBAction func buttonExt(_ sender: UIButton) {
        if let _ = Int(entry1.text!), let _ =  Int(entry2.text!){
            result.text = String(Int(entry1.text!)! - Int(entry2.text!)!)
        }
        else{
            result.text = "ERROR!!!"
        }
    }
    
    @IBAction func buttonImpact(_ sender: UIButton) {
        if let _ = Int(entry1.text!), let _ =  Int(entry2.text!){
            result.text = String(Int(entry1.text!)! * Int(entry2.text!)!)
        }
        else{
            result.text = "ERROR!!!"
        }
    }
    
    @IBAction func buttonComp(_ sender: UIButton) {
        if let _ = Int(entry1.text!), let _ =  Int(entry2.text!){
            result.text = String(Int(entry1.text!)! / Int(entry2.text!)!)
        }
        else{
            result.text = "ERROR!!!"
        }
    }
}


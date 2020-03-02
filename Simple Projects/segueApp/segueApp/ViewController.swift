//
//  ViewController.swift
//  segueApp
//
//  Created by Mustafa IŞIK on 29.02.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstVCLabel: UILabel!
    @IBOutlet weak var textFieldFVCName: UITextField!
    var username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonFVCGoToSVC(_ sender: Any) {
        username = textFieldFVCName.text!
        performSegue(withIdentifier: "goToSecondVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSecondVC"{
            let destinationVC = segue.destination as! secondViewController
            destinationVC.FVCName = "NAME : " + username
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textFieldFVCName.text = ""
    }
}


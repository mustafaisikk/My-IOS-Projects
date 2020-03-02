//
//  ViewController.swift
//  deneme
//
//  Created by Mustafa IŞIK on 26.02.2020.
//  Copyright © 2020 Ktu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBAction func buttonAction(_ sender: UIButton) {
        let value = "merhaba: " + textField.text!
        let alert = UIAlertController(title: "mesaj ", message: value, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "tamam", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


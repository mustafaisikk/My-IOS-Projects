//
//  ViewController.swift
//  ConnectUItoCode
//
//  Created by Mustafa IŞIK on 26.02.2020.
//  Copyright © 2020 Ktu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBAction func buttonAction(_ sender: UIButton) {
        let value = "Merhaba : "+textField.text!
        let alert = UIAlertController(title: "message ", message: value, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "tamam", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}


//
//  ViewController.swift
//  helloPickerView
//
//  Created by Mustafa IŞIK on 4.03.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var cars =  ["BMW", "Range Rover", "Mustang"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        let newItem = text.text
        cars.append(newItem!)
        pickerView.reloadAllComponents()
        /*
        for var2 in cars{
            print(var2)
        }
        */
        text.text = ""
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cars.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        label.text = cars [row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cars [row]
    }

}


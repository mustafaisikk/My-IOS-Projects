//
//  secondViewController.swift
//  segueApp
//
//  Created by Mustafa IŞIK on 29.02.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit

class secondViewController: UIViewController {

    @IBOutlet weak var secondVCLabel: UILabel!
    @IBOutlet weak var tectFieldSCVName: UILabel!
    
    var FVCName = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        tectFieldSCVName.text = FVCName
    }
    

}

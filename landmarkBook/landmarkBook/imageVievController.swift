//
//  imageVievController.swift
//  landmarkBook
//
//  Created by Mustafa IŞIK on 27.02.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit

class imageVievController: UIViewController {

    
    @IBOutlet weak var imageViewController: UIImageView!
    @IBOutlet weak var landmarkLabel: UILabel!
    
    var selectedLandmarkName = ""
    var selectedLandmarkImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewController.image = selectedLandmarkImage
        landmarkLabel.text = selectedLandmarkName
        
    }
    

}

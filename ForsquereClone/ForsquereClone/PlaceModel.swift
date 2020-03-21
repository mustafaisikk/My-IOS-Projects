//
//  PlaceModel.swift
//  ForsquereClone
//
//  Created by Mustafa IŞIK on 20.03.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import Foundation
import UIKit
class PlaceModel{
    static var sharedInstance = PlaceModel()
    var placeName = ""
    var placeType = ""
    var placeComment = ""
    var placeImage = UIImage()
    var placeChoosenLatitude = ""
    var placeChoosenLongitude = ""
    
    private init(){}
}

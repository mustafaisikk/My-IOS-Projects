//
//  superMusicians.swift
//  musicianClass
//
//  Created by Mustafa IŞIK on 2.03.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import Foundation

class superMusicians: musicians {
    func Sing2(){
        print("Super musician singing 2")
    }
    override func Sing() {
        print("Super musician singing 1")
    }
}

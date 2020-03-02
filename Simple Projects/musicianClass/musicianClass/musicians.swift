//
//  musicians.swift
//  musicianClass
//
//  Created by Mustafa IŞIK on 27.02.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import Foundation

enum MusicianType{
    case leadGuitar
    case Vocalist
    case Drummer
    case Bassist
    case Violenist
}

class musicians{
    var name : String
    var age :Int
    var instrument : String
    var type : MusicianType
    
    init(nameInit:String, ageInit:Int, instrumentInit:String, typeInit:MusicianType) {
        name = nameInit
        age = ageInit
        instrument = instrumentInit
        type=typeInit
        //  print("Musicians Created...\n"+"Musician Name : \(name)\n"+"Musician Age : \(age)\n" + "Musician Instrunment: \(instrument)\n"+"Musician Type : \(type)")
    }
    
    func Sing(){
        print("\(name) is Singing")
    }
}

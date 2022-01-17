//
//  CharacterModel.swift
//  SuperHeroes
//
//  Created by Selvinur Yağışan on 16.01.2022.
//

import Foundation
import ObjectMapper

struct CharacterModel : Mappable{
    
    var id: Int?
    var name: String?
    var imagePath: String?
    var imageExtension: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        imagePath <- map["thumbnail.path"]
        imageExtension <- map["thumbnail.extension"]
    }
}

//
//  DetailModel.swift
//  SuperHeroes
//
//  Created by Selvinur Yağışan on 16.01.2022.
//

import Foundation
import ObjectMapper

struct DetailModel : Mappable{
    
    var id: Int?
    var description: String?
    var title: String?
    var imagePath: String?
    var imageExtension: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        description <- map["description"]
        title <- map["title"]
        imagePath <- map["thumbnail.path"]
        imageExtension <- map["thumbnail.extension"]
    }
}

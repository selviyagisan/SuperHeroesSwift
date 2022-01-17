//
//  ViewController.swift
//  SuperHeroes
//
//  Created by Selvinur Yağışan on 16.01.2022.
//

import UIKit
import ObjectMapper

class MainVC: UIViewController {

    var data = [CharacterModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Deneme"
        getService()
    }
    func getService(){
        MarvelNetwork.makeRequest(target: .marvelChar(apiKey: "3e9a944d71a936a9971eabc33b3af197", timeStamp: "1", hashKey: "49e343093d80dd75fd2c43a4065cf3e6"), success: { (JSON) in
                if let data = Mapper<CharacterModel>().mapArray(JSONObject: JSON["data"]["results"].arrayObject) {
                    self.data = data
//                    self.tableView.reloadData()
                }
                    }, statusCode: { (statusCode, statusMessage, requestForm) in
                        print(statusCode)
                    }, failure: { (moyaError) in
                        print(moyaError)
            })
    }

}


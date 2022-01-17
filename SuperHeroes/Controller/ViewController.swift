//
//  ViewController.swift
//  SuperHeroes
//
//  Created by Selvinur Yağışan on 16.01.2022.
//

import UIKit
import ObjectMapper
import Kingfisher
import SpringIndicator

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var data = [CharacterModel]()
    var selectedIndex : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(CharactersCell.nib(), forCellReuseIdentifier: "charactersCell")
        getService()
    }
    
    func getService(){
        let indicator = SpringIndicator(frame: CGRect(x: 100, y: 100, width: 60, height: 60))
                view.addSubview(indicator)
                indicator.center = self.view.center
                indicator.start()
        
        MarvelNetwork.makeRequest(target: .marvelChar(apiKey: APIKEY, timeStamp: TIMESTAMP, hashKey: HASHKEY), success: { (JSON) in
                if let data = Mapper<CharacterModel>().mapArray(JSONObject: JSON["data"]["results"].arrayObject) {
                    self.data = data
                    self.tableView.reloadData()
                    indicator.stop()
                }
                    }, statusCode: { (statusCode, statusMessage, requestForm) in
                        print(statusCode)
                        indicator.stop()
                    }, failure: { (moyaError) in
                        print(moyaError)
                        indicator.stop()
            })
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "charactersCell", for: indexPath) as! CharactersCell
        let separatorView = UIView(frame: CGRect(x: tableView.separatorInset.left, y: 0, width: 414, height: 5))
        cell.contentView.addSubview(separatorView)
        let url = "\(self.data[indexPath.row].imagePath!).\(self.data[indexPath.row].imageExtension!)"
        cell.characterImage.kf.setImage(with: URL(string: url))
        cell.characterNameLabel.text = data[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        performSegue(withIdentifier: "characterDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "characterDetail" {
            let detailVC = segue.destination as! CharacterDetailsVC
            detailVC.deneme = String(data[selectedIndex!].id!)
        }
    }
}


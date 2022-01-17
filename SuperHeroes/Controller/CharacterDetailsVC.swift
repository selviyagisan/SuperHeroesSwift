//
//  CharacterDetailsVC.swift
//  SuperHeroes
//
//  Created by Selvinur Yağışan on 17.01.2022.
//

import UIKit
import ObjectMapper
import Kingfisher
import SpringIndicator

class CharacterDetailsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var deneme : String = ""
    var data = [DetailModel]()
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(ComicsCell.nib(), forCellReuseIdentifier: "comicsCell")
        getService()
    }
    
    func getService(){
        let indicator = SpringIndicator(frame: CGRect(x: 100, y: 100, width: 60, height: 60))
                view.addSubview(indicator)
                indicator.center = self.view.center
                indicator.start()
        
          MarvelNetwork.makeRequest(target: .comicsChar(id: deneme, apiKey: APIKEY, timeStamp: TIMESTAMP, hashKey: HASHKEY), success: { (JSON) in
                              if let data = Mapper<DetailModel>().mapArray(JSONObject: JSON["data"]["results"].arrayObject) {
                                  self.data = data
                                  self.tableView.reloadData()
                                  indicator.stop()
                              }
                                  
          },statusCode: { (statusCode, statusMessage, requestForm) in
                  print(statusCode)
                  indicator.stop()
          }, failure: { (moyaError) in
                  print(moyaError)
                  indicator.stop()
          })
      }
}

extension CharacterDetailsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "comicsCell", for: indexPath) as! ComicsCell
        cell.titleLabel.text = data[indexPath.row].title
        cell.descLabel.text = data[indexPath.row].description
        let url = "\(self.data[indexPath.row].imagePath!).\(self.data[indexPath.row].imageExtension!)"
        cell.comicsImage.kf.setImage(with: URL(string: url))
        return cell
    }
}

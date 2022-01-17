//
//  ComicsCell.swift
//  SuperHeroes
//
//  Created by Selvinur Yağışan on 17.01.2022.
//

import UIKit

class ComicsCell: UITableViewCell {

    @IBOutlet weak var comicsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ComicsCell", bundle: nil)
    }
}

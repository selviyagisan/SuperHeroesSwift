//
//  CharactersCell.swift
//  SuperHeroes
//
//  Created by Selvinur Yağışan on 17.01.2022.
//

import UIKit

class CharactersCell: UITableViewCell {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        characterImage.layer.cornerRadius = 10;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CharactersCell", bundle: nil)
    }
}

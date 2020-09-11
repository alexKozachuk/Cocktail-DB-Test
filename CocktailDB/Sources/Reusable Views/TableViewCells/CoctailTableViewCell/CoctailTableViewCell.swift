//
//  CoctailTableViewCell.swift
//  Cocktail DB
//
//  Created by Sasha on 09/09/2020.
//  Copyright © 2020 Sasha. All rights reserved.
//

import UIKit

class CoctailTableViewCell: UITableViewCell {

    @IBOutlet weak var coctailImageView: UIImageView!
    @IBOutlet weak var coctailNameLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        coctailNameLabel.font = UIFont(name: "Roboto", size: 16)
    }

}

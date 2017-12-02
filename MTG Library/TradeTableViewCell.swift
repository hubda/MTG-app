//
//  TradeTableViewCell.swift
//  MTG Library
//
//  Created by Daniel Huber on 11/30/17.
//  Copyright © 2017 Daniel Huber. All rights reserved.
//

import UIKit

class TradeTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var cardSetLabel: UILabel!
    @IBOutlet weak var cardPriceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  CardTableViewCell.swift
//  MTG Library
//
//  Created by Daniel Huber on 11/2/17.
//  Copyright © 2017 Daniel Huber. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {
    //MARK: Properties
    var index: Int = 0
    
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var cardTypeLabel: UILabel!
    @IBOutlet weak var cardSetLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

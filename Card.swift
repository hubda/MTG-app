//
//  Card.swift
//  MTG Library
//
//  Created by Daniel Huber on 11/11/17.
//  Copyright © 2017 Daniel Huber. All rights reserved.
//

import UIKit

class Card {
    //MARK: Properties
    var name: String
    var color: String
    var type: [String]
    var rulesText: String?
    var flavorText: String?
    var CMC: Int
    var manaCost: String?
    var power: Int?
    var toughness: Int?
    var set: String
    var rarity: String
    var formats: [String]?
    var photo: UIImage?
    var prices: [Float]?
    
    //MARK: Initialization
    init!(name: String, color: String, type: [String], rulesText: String?, flavorText: String?, CMC: Int, manaCost: String?, power: Int?, toughness: Int?, set: String, rarity: String, formats: [String]?, photo: UIImage?, prices: [Float]?) {
        
        //Initialize properties
        self.name = name
        self.color = color
        self.type = type
        self.rulesText = rulesText
        self.flavorText = flavorText
        self.CMC = CMC
        self.manaCost = manaCost
        self.power = power
        self.toughness = toughness
        self.set = set
        self.rarity = rarity
        self.formats = formats
        self.photo = photo
        self.prices = prices
    }
}

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
    var superType: [String]
    var subType: [String]?
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
    init!(name: String, color: String, superType: [String], subType: [String]?, rulesText: String?, flavorText: String?, CMC: Int, manaCost: String?, power: Int?, toughness: Int?, set: String, rarity: String, formats: [String]?, photo: UIImage?, prices: [Float]?) {
        
        //Initialize properties
        self.name = name
        self.color = color
        self.superType = superType
        self.subType = subType
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
    
    //MARK: Functions
    func getCMC() -> Int {
        var cmc = 0
        if manaCost == nil {
            return cmc
        }
        let manaCostArray = Array(manaCost!.characters)
        for i in 0..<manaCostArray.count {
            if manaCostArray[i] is Int {
                cmc += (manaCostArray[i] as? Int)!
            }
            else {
                cmc += 1
            }
        }
        return cmc
    }
}

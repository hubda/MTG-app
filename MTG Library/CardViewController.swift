//
//  ViewController.swift
//  MTG Library
//
//  Created by Daniel Huber on 11/2/17.
//  Copyright © 2017 Daniel Huber. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    //MARK: Properties
    var card: Card?
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardManaCost: UILabel!
    @IBOutlet weak var cardTypes: UILabel!
    @IBOutlet weak var cardRulesText: UILabel!
    @IBOutlet weak var cardFlavorText: UILabel!
    @IBOutlet weak var cardPowerToughness: UILabel!
    @IBOutlet weak var cardLegality: UILabel!
    @IBOutlet weak var cardSet: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        //Load the card if there is one.
        if (card != nil) {
            loadCard(card: card!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Private Methods
    private func loadCard(card: Card) {
        //Display card details in the card view.
        //Display the card image.
        cardImage.image = card.photo
        
        //Display the card name.
        cardName.text = card.name
        cardName.numberOfLines = 0
        print("Name: \(card.name)")
        
        //Assemble and display the card types string.
        var cardSuperTypeString: String = ""
        var cardSubTypeString: String = ""
        var cardTypeString: String = ""
        for i in 0..<card.superType.count {
            cardSuperTypeString += "\(card.superType[i]) "
        }
        cardTypeString += cardSuperTypeString
        print("Supertypes: \(cardSuperTypeString)")
        if card.subType != nil {
            for i in 0..<card.subType!.count {
                cardSubTypeString += "\(card.subType![i]) "
            }
            cardTypeString += "- \(cardSubTypeString)"
        }
        print("Subtypes: \(cardSubTypeString)")
        print("Types: \(cardTypeString)")
        cardTypes.text = cardTypeString
        
        //Display the card's mana cost if it has one.
        card.CMC = card.getCMC()
        if card.manaCost != nil {
            cardManaCost.text = "\(card.manaCost ?? "")     (\(card.CMC))"
        }
        else {
            cardManaCost.text = "(\(card.CMC))"
        }
        print("Mana cost: \(card.manaCost as Any)")
        
        //Display the card's CMC.
        
        //Display the card's rules text if it has any.
        if card.rulesText != nil {
            cardRulesText.numberOfLines = 0
            cardRulesText.text = card.rulesText
        }
        else {
            cardRulesText.text = ""
        }
        print("Rules text: \(card.rulesText as Any)")
        
        //Display the card's flavor text if it has any.
        if card.flavorText != nil {
            cardFlavorText.numberOfLines = 0
            cardFlavorText.text = card.flavorText
        }
        else {
            cardFlavorText.text = ""
        }
        print("Flavor text: \(card.flavorText as Any)")
        
        //Display the card's power if it has one.
        var powerToughness: String = ""
        if card.power != nil {
            powerToughness += "\(card.power ?? 0)"
        }
        else {
            powerToughness = ""
        }
        print("Power: \(card.power as Any)")
        
        //Display the card's toughness if it has one.
        if card.toughness != nil {
            powerToughness += " / \(card.toughness ?? 0)"
        }
        else {
            powerToughness = ""
        }
        print("Toughness: \(card.toughness as Any)")
        print("Power/Toughness: \(powerToughness)")
        cardPowerToughness.text = "\(powerToughness)\n"
        
        //Display the card's legality if it has any.
        var cardLegalityString: String = ""
        if card.formats != nil {
            cardLegality.numberOfLines = 0
            for i in 0..<card.formats!.count {
                if i > 0 {
                    cardLegalityString += ", \(card.formats![i])"
                }
                else {
                    cardLegalityString += "\(card.formats![i])"
                }
            }
            cardLegality.text = "Legal in \(cardLegalityString)"
        }
        else {
            cardLegality.text = ""
        }
        print("Legality: \(cardLegalityString)")
        
        //Display the card's expansion.
        cardSet.text = card.set
        
        //Display the card's artist.
        //cardArtist.text = "Illus. by \(card.artist)"
    }
}


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
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardManaCost: UILabel!
    @IBOutlet weak var cardTypes: UILabel!
    @IBOutlet weak var cardRulesText: UILabel!
    @IBOutlet weak var cardFlavorText: UILabel!
    @IBOutlet weak var cardPower: UILabel!
    @IBOutlet weak var cardToughness: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    
    
    //MARK: Private Methods
    //private func loadSampleCard() {
        //cardImage = 
        //let plainsType = ["Basic", "Land", "Plains"]
        //cardText = "{T}: Add {W} to your mana pool"
        //let legality = ["Standard", "Modern", "Legacy", "Vintage", "Commander"]
        
        //guard let plains = Card(name: "Plains", color: "C", type: plainsType, rulesText: plainsText, flavorText: nil, CMC: 0, manaCost: nil, power: nil, toughness: nil, set: "IXN", rarity: "C", formats: legality, photo: plainsImage, prices: nil) else {
            //fatalError("Unable to instantiate Plains")
        //}
    //}
}


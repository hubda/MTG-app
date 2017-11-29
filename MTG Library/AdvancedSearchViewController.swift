//
//  AdvancedSearchViewController.swift
//  MTG Library
//
//  Created by Daniel Huber on 11/20/17.
//  Copyright © 2017 Daniel Huber. All rights reserved.
//

import UIKit
import os.log
import  Foundation

class AdvancedSearchViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var cardNameText: UITextField!
    @IBOutlet weak var cardRulesText: UITextField!
    @IBOutlet weak var cardTypesText: UITextField!
    @IBOutlet weak var colorToggle: ColorSearchControl!
    @IBOutlet weak var multicolorToggle: UIButton!
    @IBOutlet weak var selectedColorsToggle: UIButton!
    @IBOutlet weak var manaCostToggle: UITextField!
    @IBOutlet weak var manaCostComparison: UISegmentedControl!
    @IBOutlet weak var cmcToggle: UITextField!
    @IBOutlet weak var cmcComparison: UISegmentedControl!
    @IBOutlet weak var powerText: UITextField!
    @IBOutlet weak var powerComparison: UISegmentedControl!
    @IBOutlet weak var toughnessText: UITextField!
    @IBOutlet weak var toughnessComparison: UISegmentedControl!
    @IBOutlet weak var formatSelector: UIPickerView!
    @IBOutlet weak var raritySelector: UIPickerView!
    @IBOutlet weak var cardFlavorText: UITextField!
    @IBOutlet weak var artistText: UITextField!
    @IBOutlet weak var searchCall: UIBarButtonItem!
    var unfilteredCardList = [Card]()
    var filteredCardList = [Card]()

    override func viewDidLoad() {
        super.viewDidLoad()

        //Set the filtered card list equal to the unfiltered list.
        filteredCardList = unfilteredCardList
        print("Unfiltered list: \(filteredCardList)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    //Cancel the advanced search
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    //Prepare to segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        //Configure the card list only when the search button is pressed.
        guard let button = sender as? UIBarButtonItem, button === searchCall else {
            os_log("The search button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        print("Preparing to segue from advanced search")
        //Set filtered card list
        filterCardList()
    }
    
    //MARK: Private Functions
    //Filter the list of cards by each term and send the filtered card list back.
    func filterCardList() {
        var flags: [Int] = []
        //filteredCardList = unfilteredCardList
        //For each card in the list, check its propeies against the search terms
        cardIterate: for card in filteredCardList {
            //Check that its name contains the name string
            if let searchText = cardNameText.text, !(cardNameText.text?.isEmpty)! {
                if card.name.lowercased().contains(searchText) {
                    filteredCardList.append(card)
                    print("Filtered name list: \(filteredCardList)")
                    flags.append(1)
                }
                else {
                    flags.append(0)
                    continue cardIterate
                }
            }
            
            //Check that its rules text contains the rules text string
            if let searchText = cardRulesText.text, !(cardRulesText.text?.isEmpty)! {
                if (card.rulesText?.lowercased().contains(searchText))! {
                    filteredCardList.append(card)
                    print("Filtered rules text list: \(filteredCardList)")
                    flags.append(1)
                }
                else {
                    flags.append(0)
                    continue cardIterate
                }
            }

            //Check that its supertypes list contains the types string
            if let searchText =  cardTypesText.text, !(cardTypesText.text?.isEmpty)! {
                let searchTypesArray = separateTypesString(types: searchText)
                for typeInSearch in searchTypesArray {
                    for typeInCard in card.superType {
                        if typeInCard.lowercased().contains(typeInSearch) {
                            filteredCardList.append(card)
                            print("Filtered supertype list: \(filteredCardList)")
                            flags.append(1)
                        }
                        else {
                            flags.append(0)
                            continue cardIterate
                        }
                    }
                }
            }

            //Check that its subtypes list contains the types string
            if let searchText =  cardTypesText.text, !(cardTypesText.text?.isEmpty)!, !(card.subType?.isEmpty)! {
                let searchTypesArray = separateTypesString(types: searchText)
                for typeInSearch in searchTypesArray {
                    for typeInCard in card.subType! {
                        if typeInCard.lowercased().contains(typeInSearch) {
                            filteredCardList.append(card)
                            print("Filtered subtype list: \(filteredCardList)")
                            flags.append(1)
                        }
                        else {
                            flags.append(0)
                            continue cardIterate
                        }
                    }
                }
            }
            
            //Check that its colors contain the checked colors
            //If the card's colors don't contain any one of the checked colors, continue
            for i in 0..<colorToggle.symbolCount {
                if colorToggle.colorButtons[i].isSelected {
                    //Check that the card costs a given color cost as long as it dooesn't have devoid
                    //Default search - Search for the cards that include these colors
                    if !multicolorToggle.isEnabled, !selectedColorsToggle.isEnabled {
                        let cardColorArray = card.color.components(separatedBy: "")
                        for cardColor in cardColorArray {
                            if colorToggle.colorButtons[i].titleLabel?.text! != cardColor {
                                //The card does not have one of the selected colors.
                                continue cardIterate
                            }
                        }
                    }
                    
                    //"Multicolor" search - Search for the cards that include these colors and have more than one color
                    if multicolorToggle.isEnabled {
                        if !card.isMulticolor() {
                            //The card is not multicolor.
                            continue cardIterate
                        }
                    }
                    
                    //"Selected only" search - Search for the cards that include these colors and no others
                    if selectedColorsToggle.isEnabled {
                        filteredCardList = filteredCardList.filter { card in
                            let list = card.color.contains((colorToggle.colorButtons[i].titleLabel?.text!)!)
                            print("Filtered color list: \(list)")
                            return list
                        }
                    }
                }
            
            //Check that its mana cost matches
            //Check that its cmc matches
            //Check that its power matches
            //Check that its toughness matches
            //Check that its formats match
            //Check that its rarity matches
            //Check that its flavor text matches
            //Check that its artist matches
            //Check that its set matches
        }
        
        //Filter by color, if applicable.
        /*A card has a certain color if:
         It costs that color to cast
         It has a color indicator
         It doesn't have devoid or other text that says it's colorless
        */
        for i in 0..<colorToggle.symbolCount {
            if colorToggle.colorButtons[i].isSelected {
                //Check that the card costs a given color cost as long as it dooesn't have devoid
                //Default search - Search for the cards that include these colors
                if !multicolorToggle.isEnabled, !selectedColorsToggle.isEnabled {
                    
                }
                
                //"Multicolor" search - Search for the cards that include these colors and have more than one color
                if multicolorToggle.isEnabled {
                    if !card.isMulticolor() {
                        continue
                    }
                }
                
                //"Selected only" search - Search for the cards that include these colors and no others
                if selectedColorsToggle.isEnabled {
                    filteredCardList = filteredCardList.filter { card in
                        let list = card.color.contains((colorToggle.colorButtons[i].titleLabel?.text!)!)
                        print("Filtered color list: \(list)")
                        return list
                    }
                }
                //Check the card's color indicator
                /*switch i {
                case 0:
                    //Filter by white cards
                    filteredCardList = filteredCardList.filter { card in
                        let list = card.color.contains((colorToggle.colorButtons[i].titleLabel?.text!)!)
                        print("Filtered white list: \(list)")
                        return list
                    }
                case 1:
                    //Filter by blue cards
                    filteredCardList = filteredCardList.filter { card in
                        let list = card.color.contains((colorToggle.colorButtons[i].titleLabel?.text!)!)
                        print("Filtered blue list: \(list)")
                        return list
                    }
                case 2:
                    //Filter by black cards
                case 3:
                    //Filter by red cards
                case 4:
                    //Filter by green cards
                case 5:
                    //Filter by colorless cards
                default:
                    //Don't filter by color
                }*/
            }
            
            if let searchText = cardTypesText.text, !(cardTypesText.text?.isEmpty)! {
                filteredCardList = filteredCardList.filter { card in
                    let list = card.superType.contains(searchText)
                    print("Filtered types list: \(list)")
                    return list
                }
            }
        }
        
        }
        
        //Turn a string into an array of types.
        func separateTypesString(types: String) -> [String] {
            let typesString = types.components(separatedBy: " ")
            return typesString
        }
    }
}

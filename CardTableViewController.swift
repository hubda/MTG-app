//
//  CardTableViewController.swift
//  MTG Library
//
//  Created by Daniel Huber on 11/11/17.
//  Copyright © 2017 Daniel Huber. All rights reserved.
//

import UIKit

class CardTableViewController: UITableViewController, UISearchResultsUpdating {
    //MARK: Properties
    var cards = [Card]()
    var filteredCards = [Card]()
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        
        //Load the sample cards.
        loadSampleCards()
        
        //Configure the search bar.
        filteredCards = cards
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCards.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "CardTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CardTableViewCell else {
            fatalError("The dequeued cell is not an instance of CardTableViewCell")
        }
        //print("indexPath.row: \(indexPath.row)")
        //print("filteredCards.count: \(filteredCards.count)")
        let card = filteredCards[indexPath.row]
        var cardSuperTypeString: String = ""
        var cardSubTypeString: String = ""
        var cardTypeString: String = ""
        for i in 0..<card.superType.count {
            cardSuperTypeString += "\(card.superType[i]) "
        }
        cardTypeString += "\(cardSuperTypeString) - "
        if card.subType != nil {
            for i in 0..<card.subType!.count {
                cardSubTypeString += "\(card.subType![i]) "
            }
            cardTypeString += cardSubTypeString
        }
        cell.cardTypeLabel.text = cardTypeString
        cell.cardNameLabel.text = card.name
        cell.cardSetLabel.text = card.set
        if card.rarity == "U" {
            cell.cardSetLabel.textColor = UIColor.gray
        }
        else if card.rarity == "R" {
            cell.cardSetLabel.textColor = UIColor.yellow
        }
        else if card.rarity == "M" {
            cell.cardSetLabel.textColor = UIColor.orange
        }
        cell.index = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //Set the height of the table cells.
        return 70
    }
    
    /*override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Actions to take place when the cell is clicked.
    }*/

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        //print("Segue sender: \(sender)")
        //print("segue.destination: \(segue.destination)")
        
        //Send the card info to the new card view.
        if let cardCell = sender as? CardTableViewCell {
            if let cvc = segue.destination as? CardViewController {
                let card: Card = filteredCards[cardCell.index]
                cvc.card = card
            }
        }
        
        //Send the card list to the advanced search view.
        else if sender is UIBarButtonItem {
            if let navCon = segue.destination as? UINavigationController, let destViewCon = navCon.viewControllers.first as? AdvancedSearchViewController {
                let cardList: [Card] = cards
                destViewCon.unfilteredCardList = cardList
            }
        }
        
        else {
            return
        }
    }
    
    //MARK: Actions
    //Filter the card list on search
    @IBAction func unwindToCardList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AdvancedSearchViewController, let filteredList: [Card]? = sourceViewController.filteredCardList {
            filteredCards = filteredList!
            self.tableView.reloadData()
        }
    }

    //MARK: Private Methods
    private func loadSampleCards() {
        let plainsImage = UIImage(named: "Plains")
        let islandImage = UIImage(named: "Island")
        let swampImage = UIImage(named: "Swamp")
        let mountainImage = UIImage(named: "Mountain")
        let forestImage = UIImage(named: "Forest")
        let animarImage = UIImage(named: "Animar")
        
        let plainsSuperType = ["Basic", "Land"]
        let islandSuperType = ["Basic", "Land"]
        let swampSuperType = ["Basic", "Land"]
        let mountainSuperType = ["Basic", "Land"]
        let forestSuperType = ["Basic", "Land"]
        let animarSuperType = ["Legendary", "Creature"]
        
        let plainsSubType = ["Plains"]
        let islandSubType = ["Island"]
        let swampSubType = ["Swamp"]
        let mountainSubType = ["Mountain"]
        let forestSubType = ["Forest"]
        let animarSubType = ["Elemental"]
        
        let plainsText = "{T}: Add {W} to your mana pool"
        let islandText = "{T}: Add {U} to your mana pool"
        let swampText = "{T}: Add {B} to your mana pool"
        let mountainText = "{T}: Add {R} to your mana pool"
        let forestText = "{T}: Add {G} to your mana pool"
        let animarText = "Protection from white and from black Whenever you cast a creature spell, put a +1/+1 counter on Animar, Soul of Elements. Creature spells you cast cost {1} less to cast for each +1/+1 counter on Animar."
        
        let legality = ["Standard", "Modern", "Legacy", "Vintage", "Commander"]
        let animarLegality = ["Legacy",  "Vintage", "Commander"]
        
        guard let plains = Card(name: "Plains", color: "C", superType: plainsSuperType, subType: plainsSubType, rulesText: plainsText, flavorText: nil, CMC: 0, manaCost: nil, power: nil, toughness: nil, set: "IXN", rarity: "C", formats: legality, photo: plainsImage, prices: nil) else {
            fatalError("Unable to instantiate Plains")
        }
        
        guard let island = Card(name: "Island", color: "C", superType: islandSuperType, subType: islandSubType, rulesText: islandText, flavorText: nil, CMC: 0, manaCost: nil, power: nil, toughness: nil, set: "IXN", rarity: "C", formats: legality, photo: islandImage, prices: nil) else {
            fatalError("Unable to instantiate Island")
        }
        
        guard let swamp = Card(name: "Swamp", color: "C", superType: swampSuperType, subType: swampSubType, rulesText: swampText, flavorText: nil, CMC: 0, manaCost: nil, power: nil, toughness: nil, set: "IXN", rarity: "C", formats: legality, photo: swampImage, prices: nil) else {
            fatalError("Unable to instantiate Swamp")
        }
        
        guard let mountain = Card(name: "Mountain", color: "C", superType: mountainSuperType, subType: mountainSubType, rulesText: mountainText, flavorText: nil, CMC: 0, manaCost: nil, power: nil, toughness: nil, set: "IXN", rarity: "C", formats: legality, photo: mountainImage, prices: nil) else {
            fatalError("Unable to instantiate Mountain")
        }
        
        guard let forest = Card(name: "Forest", color: "C", superType: forestSuperType, subType: forestSubType, rulesText: forestText, flavorText: nil, CMC: 0, manaCost: nil, power: nil, toughness: nil, set: "IXN", rarity: "C", formats: legality, photo: forestImage, prices: nil) else {
            fatalError("Unable to instantiate Forest")
        }
        
        guard let animar = Card(name: "Animar,  Soul of Elements", color: "URG", superType: animarSuperType, subType: animarSubType, rulesText: animarText, flavorText: nil, CMC: 3, manaCost: "URG", power: 1, toughness: 1, set: "CMD", rarity: "M", formats: animarLegality, photo: animarImage, prices: nil) else {
            fatalError("Unable to instantiate Plains")
        }
        
        cards += [plains, island, swamp, mountain, forest, animar]
    }
    
    //Update the search results whenever as new character is entered.
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            filteredCards = cards.filter { card in
                let list = card.name.lowercased().contains(searchText.lowercased())
                print("List: \(list)")
                return list
            }
        }
        else {
            filteredCards = cards
        }
        tableView.reloadData()
    }
}

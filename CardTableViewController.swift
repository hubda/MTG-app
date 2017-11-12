//
//  CardTableViewController.swift
//  MTG Library
//
//  Created by Daniel Huber on 11/11/17.
//  Copyright © 2017 Daniel Huber. All rights reserved.
//

import UIKit

class CardTableViewController: UITableViewController {
    //MARK: Properties
    var cards = [Card]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load the sample data.
        loadSampleCards()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return cards.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "CardTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CardTableViewCell else {
            fatalError("The dequeued cell is not an instance of CardTableViewCell")
        }
        
        let card = cards[indexPath.row]
        cell.cardNameLabel.text = card.name
        cell.cardTypeLabel.text = card.type[0] + " " + card.type[1] + " - " + card.type[2]
        cell.cardTextLabel.text = card.rulesText
        return cell
    }

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Private Methods
    private func loadSampleCards() {
        let plainsImage = UIImage(named: "Plains")
        let islandImage = UIImage(named: "Island")
        let swampImage = UIImage(named: "Swamp")
        let mountainImage = UIImage(named: "Mountain")
        let forestImage = UIImage(named: "Forest")
        
        let plainsType = ["Basic", "Land", "Plains"]
        let islandType = ["Basic", "Land", "Island"]
        let swampType = ["Basic", "Land", "Swamp"]
        let mountainType = ["Basic", "Land", "Mountain"]
        let forestType = ["Basic", "Land", "Forest"]
        
        let plainsText = "{T}: Add {W} to your mana pool"
        let islandText = "{T}: Add {U} to your mana pool"
        let swampText = "{T}: Add {B} to your mana pool"
        let mountainText = "{T}: Add {R} to your mana pool"
        let forestText = "{T}: Add {G} to your mana pool"
        
        let legality = ["Standard", "Modern", "Legacy", "Vintage", "Commander"]
        
        guard let plains = Card(name: "Plains", color: "C", type: plainsType, rulesText: plainsText, flavorText: nil, CMC: 0, manaCost: nil, power: nil, toughness: nil, set: "IXN", rarity: "C", formats: legality, photo: plainsImage, prices: nil) else {
            fatalError("Unable to instantiate Plains")
        }
        
        guard let island = Card(name: "Island", color: "C", type: islandType, rulesText: islandText, flavorText: nil, CMC: 0, manaCost: nil, power: nil, toughness: nil, set: "IXN", rarity: "C", formats: legality, photo: islandImage, prices: nil) else {
            fatalError("Unable to instantiate Island")
        }
        
        guard let swamp = Card(name: "Swamp", color: "C", type: swampType, rulesText: swampText, flavorText: nil, CMC: 0, manaCost: nil, power: nil, toughness: nil, set: "IXN", rarity: "C", formats: legality, photo: swampImage, prices: nil) else {
            fatalError("Unable to instantiate Swamp")
        }
        
        guard let mountain = Card(name: "Mountain", color: "C", type: mountainType, rulesText: mountainText, flavorText: nil, CMC: 0, manaCost: nil, power: nil, toughness: nil, set: "IXN", rarity: "C", formats: legality, photo: mountainImage, prices: nil) else {
            fatalError("Unable to instantiate Mountain")
        }
        
        guard let forest = Card(name: "Forest", color: "C", type: forestType, rulesText: forestText, flavorText: nil, CMC: 0, manaCost: nil, power: nil, toughness: nil, set: "IXN", rarity: "C", formats: legality, photo: forestImage, prices: nil) else {
            fatalError("Unable to instantiate Forest")
        }
        
        cards += [plains, island, swamp, mountain, forest]
    }
}

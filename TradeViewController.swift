//
//  TradeViewController.swift
//  MTG Library
//
//  Created by Daniel Huber on 11/30/17.
//  Copyright © 2017 Daniel Huber. All rights reserved.
//

import UIKit

class TradeViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var cardSearchBar: UISearchBar!
    @IBOutlet weak var leftAddCard: UIButton!
    @IBOutlet weak var rightAddCard: UIButton!
    @IBOutlet weak var leftTable: UITableView!
    @IBOutlet weak var rightTable: UITableView!
    @IBOutlet weak var leftTotal: UILabel!
    @IBOutlet weak var rightTotal: UILabel!
    
    let searchController = UISearchController(searchResultsController: nil)
    var cards = [Card]()
    var filteredCardList = [Card]()
    var leftCardList = [Card]()
    var rightCardList = [Card]()

    override func viewDidLoad() {
        super.viewDidLoad()
        filteredCardList = cards
        var total = 0.00
        for card in leftCardList {
            //total += card.getPrice()
        }
        total = 0
        for card in rightCardList {
            //total += card.getPrice()
        }
        
        //Configure the search bar.
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Entered tableView")
        let cellIdentifier = "TradeTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TradeTableViewCell else {
            fatalError("The dequeued cell is not an instance of TradeTableViewCell")
        }
        
        if tableView == leftTable {
            let card = leftCardList[indexPath.row]
            cell.cardNameLabel.text = card.name
            cell.cardSetLabel.text = card.set
            cell.cardPriceLabel.text = "\(card.getPrice())"
        }
        
        else if tableView == rightTable {
            let card = rightCardList[indexPath.row]
            cell.cardNameLabel.text = card.name
            cell.cardSetLabel.text = card.set
            cell.cardPriceLabel.text = "\(card.getPrice())"
        }
        
        else {
            print("tableView is not left or right")
        }
        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Functions
    //Need to search for a card, suggest a card, after clicking on it, add it to the table on the side on which the button was clicked.
    
    //MARK: Actions
    @IBAction func addToLeftSide(_ sender: UIButton) {
        print("button clicked")
        for card in cards {
            print("\(card.getPrice())")
        }
        if !(cardSearchBar.text?.isEmpty)! {
            //Find the card in the card list.
            for card in cards {
                if card.name == cardSearchBar.text! {
                    leftCardList.append(card)
                    return
                }
            }
            print("\(cardSearchBar.text!) is not a Magic card.")
        }
    }
    
    @IBAction func addToRightSide(_ sender: UIButton) {
        if !(cardSearchBar.text?.isEmpty)! {
            //Find the card in the card list.
            for card in cards {
                if card.name == cardSearchBar.text! {
                    rightCardList.append(card)
                    return
                }
            }
            print("\(cardSearchBar.text!) is not a Magic card.")
        }
    }
}

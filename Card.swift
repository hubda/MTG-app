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
    
    func isMulticolor() -> Bool {
        let colorArray = color.components(separatedBy: "")
        if colorArray.count > 1 {
            return true
        }
        return false
    }
    
    func getPrice() {
        print("Entered getPrice")
        /* let urlString = URL(string: "http://api.tcgplayer.com/v1.6.0/catalog/categories/1/search/manifest")
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        }*/
        //let todoEndpoint: String = "https://jsonplaceholder.typicode.com/todos/1"
        let todoEndpoint: String = "http://api.tcgplayer.com/v1.6.0/catalog/categories/1"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            //Check for errors
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error!)
                return
            }
            //Check that data were received
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            //Parse results as JSON
            do {
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] else {
                    print("error trying to convert data to JSON")
                    return
                }
                print("The todo is: " + todo.description)
                guard let todoTitle = todo["title"] as? String else {
                    print("Could not get todo title from JSON")
                    return
                }
                print("The title is: " + todoTitle)
            }
            catch {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
        //return 0.00
    }
}

//
//  ColorSearchControl.swift
//  MTG Library
//
//  Created by Daniel Huber on 11/20/17.
//  Copyright © 2017 Daniel Huber. All rights reserved.
//

import UIKit

class ColorSearchControl: UIStackView {

    //MARK: Properties
    var colorButtons = [UIButton]()
    @IBInspectable var symbolSize: CGSize = CGSize(width: 55.0, height: 55.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var symbolCount: Int = 6 {
        didSet {
            setupButtons()
        }
    }
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Private Functions
    private func setupButtons() {
        //Load symbol images
        let bundle = Bundle(for: type(of: self))
        let whiteUnselected = UIImage(named: "White Unselected", in: bundle, compatibleWith: self.traitCollection)
        let whiteSelected = UIImage(named: "White Selected", in: bundle, compatibleWith: self.traitCollection)
        let blueUnselected = UIImage(named: "Blue Unselected", in: bundle, compatibleWith: self.traitCollection)
        let blueSelected = UIImage(named: "Blue Selected", in: bundle, compatibleWith: self.traitCollection)
        let blackUnselected = UIImage(named: "Black Unselected", in: bundle, compatibleWith: self.traitCollection)
        let blackSelected = UIImage(named: "Black Selected", in: bundle, compatibleWith: self.traitCollection)
        let redUnselected = UIImage(named: "Red Unselected", in: bundle, compatibleWith: self.traitCollection)
        let redSelected = UIImage(named: "Red Selected", in: bundle, compatibleWith: self.traitCollection)
        let greenUnselected = UIImage(named: "Green Unselected", in: bundle, compatibleWith: self.traitCollection)
        let greenSelected = UIImage(named: "Green Selected", in: bundle, compatibleWith: self.traitCollection)
        let colorlessUnselected = UIImage(named: "Colorless Unselected", in: bundle, compatibleWith: self.traitCollection)
        let colorlessSelected = UIImage(named: "Colorless Selected", in: bundle, compatibleWith: self.traitCollection)
        
        //Clear any existing buttons
        for button in colorButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        colorButtons.removeAll()
        
        for i in 0..<symbolCount {
            //Create the button
            let button = UIButton()
            switch(i) {
            case 0:
                button.titleLabel?.text = "W"
                button.setImage(whiteUnselected, for: .normal)
                button.setImage(whiteSelected, for: .highlighted)
                button.setImage(whiteSelected, for: .selected)
                button.setImage(whiteSelected, for: [.highlighted, .selected])
                button.accessibilityLabel = "Search white cards"
            case 1:
                button.titleLabel?.text = "U"
                button.setImage(blueUnselected, for: .normal)
                button.setImage(blueSelected, for: .highlighted)
                button.setImage(blueSelected, for: .selected)
                button.setImage(blueSelected, for: [.highlighted, .selected])
                button.accessibilityLabel = "Search blue cards"
            case 2:
                button.titleLabel?.text = "B"
                button.setImage(blackUnselected, for: .normal)
                button.setImage(blackSelected, for: .highlighted)
                button.setImage(blackSelected, for: .selected)
                button.setImage(blackSelected, for: [.highlighted, .selected])
                button.accessibilityLabel = "Search black cards"
            case 3:
                button.titleLabel?.text = "R"
                button.setImage(redUnselected, for: .normal)
                button.setImage(redSelected, for: .highlighted)
                button.setImage(redSelected, for: .selected)
                button.setImage(redSelected, for: [.highlighted, .selected])
                button.accessibilityLabel = "Search red cards"
            case 4:
                button.titleLabel?.text = "G"
                button.setImage(greenUnselected, for: .normal)
                button.setImage(greenSelected, for: .highlighted)
                button.setImage(greenSelected, for: .selected)
                button.setImage(greenSelected, for: [.highlighted, .selected])
                button.accessibilityLabel = "Search green cards"
            case 5:
                button.titleLabel?.text = "C"
                button.setImage(colorlessUnselected, for: .normal)
                button.setImage(colorlessSelected, for: .highlighted)
                button.setImage(colorlessSelected, for: .selected)
                button.setImage(colorlessSelected, for: [.highlighted, .selected])
                button.accessibilityLabel = "Search colorless cards"
            default:
                button.backgroundColor = UIColor.red
            }
            
            //Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: symbolSize.height).isActive = true
            //button.widthAnchor.constraint(equalToConstant: symbolSize.width).isActive = true
            
            
            //Set up the button action
            button.addTarget(self, action: #selector(ColorSearchControl.colorButtonTapped(button:)), for: .touchUpInside)
            
            //Add the button to the stack
            addArrangedSubview(button)
            colorButtons.append(button)
        }
    }
    
    //MARK: Button Action
    func colorButtonTapped(button: UIButton) {
        /*guard let index = colorButtons.index(of: button) else {
            fatalError("The button \(button) is not in the colorButtons array:  \(colorButtons)")
        }*/
        
        let hintString: String?
        
        //Toggle button highlighting
        if !button.isSelected {
            button.isSelected = true
            hintString = "Tap to disable this color filter"
        }
        else {
            button.isSelected = false
            hintString = "Tap to enable this color filter"
        }
        button.accessibilityHint = hintString
        
        //Set search criteria
    }
}

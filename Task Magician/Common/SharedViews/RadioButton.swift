//
//  RadioButton.swift
//  Task Magician
//
//  Created by Сергей Павленок on 21.07.2021.
//

import UIKit

class RadioButton: UIButton {
    var alternateButton: [RadioButton]?
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2.0
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.white
        self.setTitleColor(UIColor.black, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        self.tintColor = UIColor.white
    }
    
    func unselectAlternateButtons() {
        var allRelatedButtonsDisabled = true
        for aButton: RadioButton in alternateButton! {
            if aButton.isSelected == true {
                allRelatedButtonsDisabled = false
            }
        }
        if alternateButton != nil  && !allRelatedButtonsDisabled {
            self.isSelected = true
            
            for aButton: RadioButton in alternateButton! {
                aButton.isSelected = false
            }
        } else {
            toggleButton()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    }
    
    
    func toggleButton() {
        self.isSelected = !isSelected
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.borderColor = UIColor.green.cgColor
            } else {
                self.layer.borderColor = UIColor.black.cgColor
            }
        }
    }
}

//
//  UIViewController+createCommonButton.swift
//  Task Magician
//
//  Created by Сергей Павленок on 15.07.2021.
//

import UIKit

extension UIViewController {
    func createCommonButton(button: UIButton, titleColor: UIColor, backgroundColor: UIColor, title: String) {
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    }
}

//
//  UIVIewController+createVkButton.swift
//  Task Magician
//
//  Created by Сергей Павленок on 15.07.2021.
//

import UIKit

extension UIViewController {
    func createVKButton(button: UIButton) {
        button.layer.cornerRadius = 10
        button.layer.backgroundColor = UIColor.white.cgColor
        button.setTitle("Продолжить через VK", for: .normal) 
        button.setImage(UIImage(named: "ic_vk_logo_nb"), for: .normal)
        button.imageEdgeInsets.left = -50
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
}

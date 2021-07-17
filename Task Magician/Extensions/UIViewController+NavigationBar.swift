//
//  UIViewController+hideNavBar.swift
//  Task Magician
//
//  Created by Сергей Павленок on 17.07.2021.
//

import UIKit

extension UIViewController {
    func makeNavigationBarClear() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func restoreDefaultNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
}

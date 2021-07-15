//
//  Storyboard+loadFromStoryboard.swift
//  Task Magician
//
//  Created by Сергей Павленок on 13.07.2021.
//

import UIKit

extension UIViewController {
    class func loadFromStoryboard<T: UIViewController>() -> T {
        let nameVC = String(describing: T.self)
        // 13 used for slice out ViewController in the end. Bad practice. Needs to be improved.
        let finalIndex = nameVC.count - 14
        let name = nameVC[0..<finalIndex]
        let storyboard = UIStoryboard(name: name, bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? T {
            return viewController
        } else {
            fatalError("Error: No initial view controller in \(name) storyboard!")
        }
    }
}

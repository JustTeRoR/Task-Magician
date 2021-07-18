//
//  TableViewCell+configureCommonLabels.swift
//  Task Magician
//
//  Created by Сергей Павленок on 18.07.2021.
//

import UIKit

extension UITableViewCell {
    func configureCommonStatusLabel(label: UILabel, status: TaskStatus) {
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.textColor = UIColor.white
        switch status {
        case .Open:
            label.backgroundColor = UIColor.darkGray
        case .InProgress:
            label.backgroundColor = UIColor.systemBlue
        case .OnHold:
            label.backgroundColor = UIColor.lightGray
        case .Completed:
            label.backgroundColor = UIColor.green
        }
    }
    
    func configureCommonGroupLabel(label: UILabel, group: TaskGroup) {
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.textColor = UIColor.white
        switch group {
        case .Private:
            label.backgroundColor = UIColor.systemPink
        case .Work:
            label.backgroundColor = UIColor.red
        case .Assignments:
            label.backgroundColor = UIColor.systemGreen
        case .Shopping:
            label.backgroundColor = UIColor.purple
        }
    }
}

//
//  ViewTasksViewController+tableView.swift
//  Task Magician
//
//  Created by Сергей Павленок on 16.07.2021.
//

import UIKit
// swiftlint:disable force_cast
extension ViewTasksViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell
        //let model = replacePartList[indexPath.row]
        //cell.commonInit(serialNumber: model.serialNumber, category: model.partTypeName, make: model.makeName, isOEM: model.isOEM, quantity: model.quantity)
        return cell
    }
}

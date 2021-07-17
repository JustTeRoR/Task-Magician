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
        let model = tasks[indexPath.row]
        cell.commonInit(taskModel: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // swiftlint:disable force_try
            try! self.realm.write {
                realm.delete(tasks[indexPath.row])
                self.refresh()
                self.tasksTable.reloadData()
            }
        }
    }
}

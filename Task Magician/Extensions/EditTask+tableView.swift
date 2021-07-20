//
//  EditTask+tableView.swift
//  Task Magician
//
//  Created by Сергей Павленок on 19.07.2021.
//

import UIKit


// swiftlint:disable force_cast
extension EditTaskViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskToChange.listOfSubtasks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subtaskCell", for: indexPath) as! SubtaskTableViewCell
        let model = taskToChange.listOfSubtasks[indexPath.row]
        cell.commonInit(subtaskModel: model, isActiveCell: false)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // swiftlint:disable force_try
            try! self.realm.write {
                taskToChange.listOfSubtasks.remove(at: indexPath.row)
                self.subtasksTable.reloadData()
            }
        }
    }
}

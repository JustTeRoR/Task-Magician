//
//  TaskTableViewCell+tableView.swift
//  Task Magician
//
//  Created by Сергей Павленок on 19.07.2021.
//

import UIKit

// swiftlint:disable force_cast
extension TaskTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskModel.listOfSubtasks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subtask_Cell", for: indexPath) as! SubtaskTableViewCell
        let model = taskModel.listOfSubtasks[indexPath.row]
        cell.commonInit(subtaskModel: model, isActiveCell: true)
        cell.callbackForCompletion = { () in
            // swiftlint:disable force_try
            try! self.realm.write {
                self.taskModel.listOfSubtasks[indexPath.row].isCompleted = true
                self.subtaskTable.reloadData()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            callbackForDeleteSubtask?(indexPath.row)
        }
    }
}

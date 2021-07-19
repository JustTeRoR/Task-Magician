//
//  CreateSubtaskViewController+tableView.swift
//  Task Magician
//
//  Created by Сергей Павленок on 19.07.2021.
//

import UIKit
// swiftlint:disable force_cast
extension CreateTaskViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subtasksForNewTask.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subtaskCell", for: indexPath) as! SubtaskTableViewCell
        let model = subtasksForNewTask[indexPath.row]
        cell.commonInit(subtaskModel: model, isActiveCell: false)
        return cell
    }
}

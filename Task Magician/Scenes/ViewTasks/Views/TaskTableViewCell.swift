//
//  TaskTableViewCell.swift
//  Task Magician
//
//  Created by Сергей Павленок on 16.07.2021.
//

import UIKit
import RealmSwift

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var taskDescription: UILabel!
    @IBOutlet weak var taskGroup: UILabel!
    @IBOutlet weak var taskStatus: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var subtaskTable: UITableView!
    
    // TODO: try to get rid of realm here
    // swiftlint:disable force_try
    let realm = try! Realm(configuration: app.currentUser!.configuration(partitionValue: app.currentUser!.id))
    var callback: (() -> Void)?
    var callbackForDeleteSubtask: ((Int) -> Void)?
    var containsSubTasks: Bool = false
    // TODO: maybe it's not good to store this here, but it's needed for initialization built in tableView
    var taskModel: Task!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    let dateFormatter: DateFormatter = {
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "ru_RU")
        dateFormater.dateFormat = "d MMM 'в' HH:mm"
        return dateFormater
    }()
    
    func commonInit(taskModel: Task) {
        self.taskModel = taskModel
        subtaskTable.layer.borderWidth = 1
        subtaskTable.layer.borderColor = UIColor.orange.cgColor
        subtaskTable.layer.cornerRadius = 10
        taskName.text = taskModel.name
        taskDescription.text = taskModel.taskDescription
        taskDescription.numberOfLines = 3
        taskDescription.lineBreakMode = .byWordWrapping
        taskDescription.sizeToFit()
        taskGroup.text = taskModel.group
        taskStatus.text = taskModel.status
        configureCommonStatusLabel(label: taskStatus, status: TaskStatus.init(rawValue: taskModel.status)!)
        configureCommonGroupLabel(label: taskGroup, group: TaskGroup.init(rawValue: taskModel.group)!)
        dateLabel.text = dateFormatter.string(from: taskModel.deadline)
        if taskModel.isCompleted {
            completeButton.setBackgroundImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
            completeButton.isEnabled = false
        } else {
            completeButton.setBackgroundImage(UIImage(systemName: "checkmark.seal"), for: .normal)
            completeButton.isEnabled = true
        }
        if taskModel.listOfSubtasks.count == 0 {
            // subtaskTable.isHidden = true
            subtaskTable.removeFromSuperview()
        } else {
            subtaskTable.dataSource = self
            subtaskTable.delegate = self
            subtaskTable.register(UINib(nibName: "SubtaskTableViewCell", bundle: nil), forCellReuseIdentifier: "subtask_Cell")
            subtaskTable.reloadData()
        }
    }

    @IBAction func completeButtonClicked(_ sender: Any) {
        completeButton.setBackgroundImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
        callback?()
    }
}

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
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    // TODO: try to get rid of realm here
    // swiftlint:disable force_try
    let realm = try! Realm(configuration: app.currentUser!.configuration(partitionValue: app.currentUser!.id))
    var callback: (() -> Void)?
    var callbackForDeleteSubtask: ((Int) -> Void)?
    var callbackForEditingTask: (() -> Void)?
    var callbackForSharingTask: (() -> Void)?
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
        if taskModel.listOfSubtasks.count == 0 {
            subtaskTable.isHidden = true
            // subtaskTable.removeFromSuperview()
        } else {
            subtaskTable.isHidden = false
            subtaskTable.dataSource = self
            subtaskTable.delegate = self
            subtaskTable.register(UINib(nibName: "SubtaskTableViewCell", bundle: nil), forCellReuseIdentifier: "subtask_Cell")
            subtaskTable.reloadData()
        }
        
        subtaskTable.layer.borderWidth = 1
        subtaskTable.layer.borderColor = UIColor.orange.cgColor
        subtaskTable.layer.cornerRadius = 10
        editButton.layer.cornerRadius = 10
        shareButton.layer.cornerRadius = 10
        taskName.text = taskModel.name
        taskDescription.text = taskModel.taskDescription
        taskDescription.numberOfLines = 3
        taskDescription.lineBreakMode = .byWordWrapping
        taskDescription.sizeToFit()
        taskGroup.text = taskModel.group
        taskStatus.text = taskModel.status
        configureCommonStatusLabel(label: taskStatus, status: TaskStatus.init(rawValue: taskModel.status)!)
        configureCommonGroupLabel(label: taskGroup, group: TaskGroup.init(rawValue: taskModel.group)!)
        let components = Calendar.current.dateComponents([.second], from: Date(), to: taskModel.deadline)
        let spentSeconds = components.second!
        if spentSeconds < 0 {
            dateLabel.textColor = UIColor.systemRed
        } else {
            dateLabel.textColor = UIColor.systemGreen
        }
        dateLabel.text = dateFormatter.string(from: taskModel.deadline)
        if taskModel.isCompleted {
            completeButton.setBackgroundImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
            completeButton.isEnabled = false
        } else {
            completeButton.setBackgroundImage(UIImage(systemName: "checkmark.seal"), for: .normal)
            completeButton.isEnabled = true
        }
    }

    // swiftlint:disable force_cast
    @IBAction func shareButtonClicked(_ sender: Any) {
        callbackForSharingTask?()
    }
    @IBAction func editButtonClicked(_ sender: Any) {
        callbackForEditingTask?()
    }
    @IBAction func completeButtonClicked(_ sender: Any) {
        completeButton.setBackgroundImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
        callback?()
    }
}

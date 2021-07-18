//
//  TaskTableViewCell.swift
//  Task Magician
//
//  Created by Сергей Павленок on 16.07.2021.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var taskDescription: UILabel!
    @IBOutlet weak var taskGroup: UILabel!
    @IBOutlet weak var taskStatus: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    var callback: (() -> Void)?
    
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
    }

    @IBAction func completeButtonClicked(_ sender: Any) {
        completeButton.setBackgroundImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
        callback?()
    }
}

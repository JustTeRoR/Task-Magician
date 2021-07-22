//
//  EditTaskViewController.swift
//  Task Magician
//
//  Created by Сергей Павленок on 19.07.2021.
//

import Foundation
import RealmSwift
import UIKit

class EditTaskViewController: UIViewController {
    @IBOutlet weak var titleInputText: UITextField!
    @IBOutlet weak var descriptionInputText: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var statePicker: UIPickerView!
    @IBOutlet weak var groupPicker: UIPickerView!
    @IBOutlet weak var subtasksTable: UITableView!
    @IBOutlet weak var subtaskInputText: UITextField!
    @IBOutlet weak var createSubtaskButton: UIButton!
    // swiftlint:disable force_try
    public var taskToChange: Task!
    var isImportingFromFile = false
    var realm: Realm!
    public var compleationHandler: (() -> Void)?
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    // MARK: Setup
    private func setup() {
        guard let user = app.currentUser else {
            fatalError("Person must be logged to access this view")
        }
        realm = try! Realm(configuration: user.configuration(partitionValue: user.id))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.view.backgroundColor = UIColor.systemGroupedBackground
        navigationController?.navigationBar.tintColor = UIColor.black
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.btnUpdateTask))
        self.navigationItem.rightBarButtonItem = saveButton
        setUpPickerView()
        createCommonButton(button: createSubtaskButton, titleColor: UIColor.white, backgroundColor: UIColor.black, title: "Добавить подзадачу")
        titleInputText.text = taskToChange.name
        descriptionInputText.text = taskToChange.taskDescription
        datePicker.date = taskToChange.deadline
        let taskStatus = TaskStatus.init(rawValue: taskToChange.status)!
        let stateIndex = TaskStatus.allCases.firstIndex(of: taskStatus)!
        statePicker.selectRow(stateIndex, inComponent: 0, animated: true)
        
        let taskGroup = TaskGroup.init(rawValue: taskToChange.group)!
        let stateGroupIndex = TaskGroup.allCases.firstIndex(of: taskGroup)!
        groupPicker.selectRow(stateGroupIndex, inComponent: 0, animated: true)
        
        subtasksTable.dataSource = self
        subtasksTable.delegate = self
        subtasksTable.register(UINib(nibName: "SubtaskTableViewCell", bundle: nil), forCellReuseIdentifier: "subtaskCell")
    }
    
    @IBAction func createNewSubtaskButtonClicked(_ sender: Any) {
        if let text = subtaskInputText.text, !text.isEmpty {
            // swiftlint:disable force_try
            try! self.realm.write {
                taskToChange.listOfSubtasks.append(Subtask(name: text, owner: app.currentUser?.id))
                subtasksTable.reloadData()
                
            }
        } else {
            print("Add something to subtask name")
        }
    }
    
    @objc func btnUpdateTask() {
        if let text = titleInputText.text, !text.isEmpty {
            let date = datePicker.date
            let taskGroup = TaskGroup.allCases[groupPicker.selectedRow(inComponent: 0)]
            let taskDescription = descriptionInputText.text ?? ""
            let taskStatus = TaskStatus.allCases[statePicker.selectedRow(inComponent: 0)]
            if isImportingFromFile == true {
                applyValuesFromFields()
                try! self.realm.write {
                    self.realm.add(Task(value: taskToChange))
                }
            } else {
                try! self.realm.write {
                    taskToChange.name = text
                    taskToChange.taskDescription = taskDescription
                    taskToChange.group = taskGroup.rawValue
                    taskToChange.status = taskStatus.rawValue
                    taskToChange.deadline = date
                    if taskStatus.rawValue != TaskStatus.Completed.rawValue {
                        taskToChange.isCompleted = false
                    } else {
                        taskToChange.isCompleted = true
                    }
                }
            }
            // swiftlint:enable force_try
            compleationHandler?()
        } else {
            print("Add something to name")
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func applyValuesFromFields() {
        let text = titleInputText.text
        let date = datePicker.date
        let taskGroup = TaskGroup.allCases[groupPicker.selectedRow(inComponent: 0)]
        let taskDescription = descriptionInputText.text ?? ""
        let taskStatus = TaskStatus.allCases[statePicker.selectedRow(inComponent: 0)]
        taskToChange.name = text!
        taskToChange.taskDescription = taskDescription
        taskToChange.group = taskGroup.rawValue
        taskToChange.status = taskStatus.rawValue
        taskToChange.deadline = date
        if taskStatus.rawValue != TaskStatus.Completed.rawValue {
            taskToChange.isCompleted = false
        } else {
            taskToChange.isCompleted = true
        }
    }
    
    private func setUpPickerView() {
        groupPicker.delegate = self
        groupPicker.dataSource = self
        statePicker.delegate = self
        statePicker.dataSource = self
    }
}

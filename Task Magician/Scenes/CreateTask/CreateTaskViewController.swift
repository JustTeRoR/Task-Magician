//
//  CreateTaskViewController.swift
//  Task Magician
//
//  Created by Сергей Павленок on 12.07.2021.
//

import UIKit
import RealmSwift

class CreateTaskViewController: UIViewController {
    @IBOutlet weak var titleInputText: UITextField!
    @IBOutlet weak var descriptionInputText: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var groupPicker: UIPickerView!
    @IBOutlet weak var subtasksTable: UITableView!
    @IBOutlet weak var subtaskInputText: UITextField!
    @IBOutlet weak var createSubtaskButton: UIButton!
    // swiftlint:disable force_try
    var subtasksForNewTask = [Subtask]()
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
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemGroupedBackground
        navigationController?.navigationBar.tintColor = UIColor.black
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.btnCreateNewTask))
        self.navigationItem.rightBarButtonItem = saveButton
        setUpPickerView()
        createCommonButton(button: createSubtaskButton, titleColor: UIColor.white, backgroundColor: UIColor.black, title: "Добавить подзадачу")
        subtasksTable.dataSource = self
        subtasksTable.delegate = self
        subtasksTable.register(UINib(nibName: "SubtaskTableViewCell", bundle: nil), forCellReuseIdentifier: "subtaskCell")
    }
    
    @IBAction func createNewSubtaskButtonClicked(_ sender: Any) {
        if let text = subtaskInputText.text, !text.isEmpty {
            subtasksForNewTask.append(Subtask(name: text, owner: app.currentUser?.id))
            subtasksTable.reloadData()
        } else {
            print("Add something to subtask name")
        }
    }
    @objc func btnCreateNewTask() {
        if let text = titleInputText.text, !text.isEmpty {
            let date = datePicker.date
            let taskGroup = TaskGroup.allCases[groupPicker.selectedRow(inComponent: 0)]
            let taskDescription = descriptionInputText.text ?? ""
            let newTask = Task(name: text, status: .Open, group: taskGroup,
                               description: taskDescription, owner: app.currentUser?.id, deadline: date)
            for subtask in subtasksForNewTask {
                newTask.listOfSubtasks.append(subtask)
            }
            // swiftlint:disable force_try
            try!self.realm.write {
                self.realm.add(newTask)
            }
            // swiftlint:enable force_try
            compleationHandler?()
        } else {
            print("Add something to name")
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setUpPickerView() {
        groupPicker.delegate = self
        groupPicker.dataSource = self
    }
}

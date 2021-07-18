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
    @IBOutlet weak var scrollView: UIScrollView!
    // swiftlint:disable force_try
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
    }
    
    @objc func btnCreateNewTask() {
        if let text = titleInputText.text, !text.isEmpty {
            let date = datePicker.date
            let newTask = Task()
            newTask.name = text
            newTask.owner = app.currentUser?.id
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

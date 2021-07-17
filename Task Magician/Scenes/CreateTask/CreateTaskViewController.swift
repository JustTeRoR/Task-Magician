//
//  CreateTaskViewController.swift
//  Task Magician
//
//  Created by Сергей Павленок on 12.07.2021.
//

import UIKit
import RealmSwift

protocol CreateTaskDisplayLogic: AnyObject
{
  func displaySomething(viewModel: CreateTask.Something.ViewModel)
}

class CreateTaskViewController: UIViewController, CreateTaskDisplayLogic {
    var interactor: CreateTaskBusinessLogic?
    var router: (NSObjectProtocol & CreateTaskRoutingLogic & CreateTaskDataPassing)?
    @IBOutlet weak var titleInputText: UITextField!
    @IBOutlet weak var descriptionInputText: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var groupPicker: UIPickerView!
    
    // swiftlint:disable force_try
    let realm = try! Realm(configuration: app.currentUser!.configuration(partitionValue: app.currentUser!.id))
    public var compleationHandler: (() -> Void)?
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        guard let user = app.currentUser else {
            fatalError("User must be logged to access to this view")
        }
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = CreateTaskInteractor()
        let presenter = CreateTaskPresenter()
        let router = CreateTaskRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
  
  // MARK: Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
          let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
          if let router = router, router.responds(to: selector) {
            router.perform(selector, with: segue)
          }
        }
    }
  
  // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemGroupedBackground
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.btnCreateNewTask))
        self.navigationItem.rightBarButtonItem = saveButton
    }

    @objc func btnCreateNewTask() {
        if let text = titleInputText.text, !text.isEmpty {
            let date = datePicker.date
            let newTask = Task()
            newTask.name = text
            newTask.owner = app.currentUser?.id
            // swiftlint:disable force_try
            
            try!self.realm.write{
                self.realm.add(newTask)
            }
            // swiftlint:enable force_try
            compleationHandler?()
        } else {
            print ("Add something to name")
        }
        self.navigationController?.popViewController(animated: true)
    }
  // MARK: Do something
  func doSomething() {
    let request = CreateTask.Something.Request()
    interactor?.doSomething(request: request)
  }
  
  func displaySomething(viewModel: CreateTask.Something.ViewModel) {
    //nameTextField.text = viewModel.name
  }
}

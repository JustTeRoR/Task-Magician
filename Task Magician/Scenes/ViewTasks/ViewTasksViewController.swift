//
//  ViewTasksViewController.swift
//  Task Magician
//
//  Created by Сергей Павленок on 13.07.2021.
//

import UIKit
import VK_ios_sdk
import RealmSwift

protocol ViewTasksDisplayLogic: AnyObject {
    func displayUserData(viewModel: ViewTasks.UserOperations.ViewModel.ViewModelData)
}

class ViewTasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TitleViewDelegate, ViewTasksDisplayLogic {

    var interactor: ViewTasksBusinessLogic?
    // swiftlint:disable force_try
    var realm: Realm!
    @IBOutlet weak var tasksTable: UITableView!
    private lazy var titleView = TitleView()
    var tasks = [Task]()
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
        let viewController = self
        let interactor = ViewTasksInteractor()
        let presenter = ViewTasksPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        guard let user = app.currentUser else {
            fatalError("Person must be logged to access this view")
        }
        realm = try! Realm(configuration: user.configuration(partitionValue: user.id))
    }
      
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = realm.objects(Task.self).map({ $0 })
        setupTopBars()
        interactor?.makeRequest(request: ViewTasks.UserOperations.Request.RequestType.getUser)
        tasksTable.dataSource = self
        tasksTable.delegate = self
        tasksTable.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "taskCell")
        tasksTable.reloadData()
    }
    
    @IBAction func addNewTask(_ sender: Any) {
        let createVC: CreateTaskViewController = CreateTaskViewController.loadFromStoryboard()
        self.navigationController?.pushViewController(createVC, animated: true)
        createVC.compleationHandler = { [weak self] in
            self?.refresh()
        }
    }
    func refresh() {
        tasks = realm.objects(Task.self).map({ $0 })
        tasksTable.reloadData()
    }
    
    private func setupTopBars() {
        let topBar = UIView(frame: UIApplication.shared.statusBarFrame)
        topBar.backgroundColor = .blue
        topBar.layer.shadowColor = UIColor.black.cgColor
        topBar.layer.shadowOpacity = 0.3
        topBar.layer.shadowOffset = CGSize.zero
        topBar.layer.shadowRadius = 8
        self.view.addSubview(topBar)

        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.titleView = titleView
        titleView.delegate = self
    }
    
    // MARK: Log out session delegate
    func buttonLogOutSession(sender: UIButton) {
        // swiftlint:disable force_cast
        let authViewController: AuthorizeUserViewController = UIStoryboard(name: "AuthorizeUser", bundle: nil)
            .instantiateViewController(withIdentifier: "AuthorizeUserViewController") as! AuthorizeUserViewController
        // swiftlint:enable force_cast
        let alert = UIAlertController(title: "Выйти?",
                                      message: "Вы всегда можете получить доступ к своему аккаунту, войдя в систему",
                                      preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertAction.Style.default, handler: { _ in
            print("\(#function)")
        }))

        alert.addAction(UIAlertAction(title: "Выйти",
                                      style: UIAlertAction.Style.destructive,
                                      handler: {(_: UIAlertAction!) in
                                        print("\(#function)")
                                        VKSdk.forceLogout()
                                        app.currentUser?.logOut()
                                        self.navigationController?.navigationBar.isHidden = true
                                        self.navigationController?.pushViewController(authViewController,
                                                                                      animated: false)
                                        self.navigationController?.viewControllers.removeFirst()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func displayUserData(viewModel: ViewTasks.UserOperations.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayUser(let userViewModel):
            titleView.set(userViewModel: userViewModel)
        }
    }
}

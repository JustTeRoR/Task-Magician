//
//  ViewTasksViewController.swift
//  Task Magician
//
//  Created by Сергей Павленок on 13.07.2021.
//

import UIKit
import VK_ios_sdk

protocol ViewTasksDisplayLogic: AnyObject {
    func displayUserData(viewModel: ViewTasks.GetUserInfo.ViewModel.ViewModelData)
    func displaySomething(viewModel: ViewTasks.Something.ViewModel)
}

class ViewTasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TitleViewDelegate, ViewTasksDisplayLogic {
    
    var interactor: ViewTasksBusinessLogic?
    var router: (NSObjectProtocol & ViewTasksRoutingLogic & ViewTasksDataPassing)?
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
        let router = ViewTasksRouter()
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
    setupTopBars()
    interactor?.makeRequest(request: ViewTasks.GetUserInfo.Request.RequestType.getUser)
    tasksTable.dataSource = self
    tasksTable.delegate = self
    tasksTable.register(UITableViewCell.self, forCellReuseIdentifier: "taskCell")
  }
    
    @IBAction func addNewTask(_ sender: Any) {
        
    }
    
  // MARK: Do something
  func doSomething() {
    let request = ViewTasks.Something.Request()
    interactor?.doSomething(request: request)
  }
  
  func displaySomething(viewModel: ViewTasks.Something.ViewModel) {
    //nameTextField.text = viewModel.name
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
        let authViewController:AuthorizeUserViewController = UIStoryboard(name: "AuthorizeUser", bundle: nil)
            .instantiateViewController(withIdentifier: "AuthorizeUserViewController") as! AuthorizeUserViewController
        // swiftlint:enable force_cast
        /*
        guard let authViewController: AuthorizeUserViewController = loginStoryboard.instantiateViewController(withIdentifier: "AuthorizeUserViewController") as? AuthorizeUserViewController else {
            print("Couldn't find the view controller")
            return
        }*/

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
                                        //LogOut and segue at authViewController
                                        VKSdk.forceLogout()
                                        app.currentUser?.logOut()
                                        self.navigationController?.pushViewController(authViewController,
                                                                                      animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func displayUserData(viewModel: ViewTasks.GetUserInfo.ViewModel.ViewModelData) {
        switch viewModel {
            case .displayUser(let userViewModel):
                titleView.set(userViewModel: userViewModel)
        }
    }
}

//
//  RegisterUserViewController.swift
//  Task Magician
//

import UIKit

protocol RegisterUserDisplayLogic: AnyObject
{
  func displaySomething(viewModel: RegisterUser.Something.ViewModel)
}

class RegisterUserViewController: UIViewController, RegisterUserDisplayLogic
{
  var interactor: RegisterUserBusinessLogic?
  var router: (NSObjectProtocol & RegisterUserRoutingLogic & RegisterUserDataPassing)?
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var vkRegisterButton: UIButton!
    
  // MARK: Object lifecycle
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
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
    let interactor = RegisterUserInteractor()
    let presenter = RegisterUserPresenter()
    let router = RegisterUserRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
    private func setupUI() {
        self.welcomeLabel.text = "Добро пожаловать"
        self.welcomeLabel.textColor = UIColor.white
        self.infoLabel.text = "Для создания аккаунта в Task Magician \n Вам необходимо войти через социальную сеть VK (ВКонтакте). \n Это займет не более полуминуты."
        self.infoLabel.textColor = UIColor.white
        self.view.backgroundColor = UIColor.orange
        self.vkRegisterButton.layer.cornerRadius = 10
        self.vkRegisterButton.layer.backgroundColor = UIColor.white.cgColor
        self.vkRegisterButton.titleLabel?.text = "Продолжить через VK"
        self.vkRegisterButton.setImage(UIImage(named: "ic_vk_logo_nb"), for: .normal)
        self.vkRegisterButton.imageEdgeInsets.left = -50
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
        //doSomething()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Make the navigation bar background clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor.white
        }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Restore the navigation bar to default
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
  // MARK: Do something
  func doSomething() {
    let request = RegisterUser.Something.Request()
    interactor?.doSomething(request: request)
  }
  func displaySomething(viewModel: RegisterUser.Something.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
    @IBAction func vkRegisterButtonClicked(_ sender: Any) {
        print("clicked")
    }
}

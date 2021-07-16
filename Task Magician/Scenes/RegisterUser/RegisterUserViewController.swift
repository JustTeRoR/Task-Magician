//
//  RegisterUserViewController.swift
//  Task Magician
//

import UIKit

class RegisterUserViewController: UIViewController {
  var interactor: RegisterUserBusinessLogic?
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
    viewController.interactor = interactor
  }
    private func setupUI() {
        self.welcomeLabel.text = "Добро пожаловать"
        self.welcomeLabel.textColor = UIColor.white
        self.infoLabel.text = "Для создания аккаунта в Task Magician \n Вам необходимо войти через социальную сеть VK (ВКонтакте). \n Это займет не более полуминуты."
        self.infoLabel.textColor = UIColor.white
        self.view.backgroundColor = UIColor.orange
        createVKButton(button: vkRegisterButton)
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
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
  
    func registerPerson(authService: AuthService) {
        let request = RegisterUser.RegisterUserProcess.Request()
        interactor?.registerPersonThroughVK(request: request, authService: authService)
    }
    @IBAction func vkRegisterButtonClicked(_ sender: Any) {
        print("Register session raised.")
        let request = RegisterUser.RegisterUserProcess.Request()
        interactor?.registerPersonThroughVK(request: request, authService: AppDelegate.shared().authService)
    }
}

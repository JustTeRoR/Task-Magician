//
//  AuthorizeUserViewController.swift
//  Task Magician
//

import UIKit

protocol AuthorizeUserDisplayLogic: AnyObject
{
    func displaySomething(viewModel: AuthorizeUser.Something.ViewModel)
}

class AuthorizeUserViewController: UIViewController, AuthorizeUserDisplayLogic {
    var interactor: AuthorizeUserBusinessLogic?
    var router: (NSObjectProtocol & AuthorizeUserRoutingLogic & AuthorizeUserDataPassing)?
    @IBOutlet weak var textLogoImage: UIImageView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var authorizeButton: UIButton!
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
        let interactor = AuthorizeUserInteractor()
        let presenter = AuthorizeUserPresenter()
        let router = AuthorizeUserRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    private func setupUI() {
        self.view.backgroundColor = UIColor.orange
        self.iconImage.image = UIImage(systemName: "list.star")
        self.iconImage.tintColor = UIColor.white
        self.textLogoImage.image = UIImage(named: "LaunchScreen-logo")
        self.registerButton.layer.borderWidth = 2
        self.registerButton.layer.cornerRadius = 10
        self.registerButton.layer.borderColor = UIColor.white.cgColor
        self.registerButton.backgroundColor = UIColor.white
        self.registerButton.setTitleColor(UIColor.black, for: .normal)
        self.registerButton.setTitle("Я новый пользователь", for: .normal)
        self.registerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        self.authorizeButton.layer.borderWidth = 2
        self.authorizeButton.layer.cornerRadius = 10
        self.authorizeButton.layer.borderColor = UIColor.white.cgColor
        self.authorizeButton.setTitle("У меня уже есть аккаунт", for: .normal)
        self.authorizeButton.setTitleColor(UIColor.white, for: .normal)
        self.authorizeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
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
        // doSomething()
        setupUI()
    }
    // MARK: Do something
    func doSomething() {
        let request = AuthorizeUser.Something.Request()
        interactor?.doSomething(request: request)
    }
    func displaySomething(viewModel: AuthorizeUser.Something.ViewModel) {
        // nameTextField.text = viewModel.name
    }
}

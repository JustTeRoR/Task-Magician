//
//  AuthorizeUserViewController.swift
//  Task Magician
//

import UIKit

protocol AuthorizeUserDisplayLogic: AnyObject {
    func displaySomething(viewModel: AuthorizeUser.Something.ViewModel)
}

class AuthorizeUserViewController: UIViewController, AuthorizeUserDisplayLogic {
    var interactor: AuthorizeUserBusinessLogic?
    var router: (NSObjectProtocol & AuthorizeUserRoutingLogic & AuthorizeUserDataPassing)?
    var transparentView = UIView()
    var slideUpView = UIView()
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
        self.slideUpView.backgroundColor = UIColor.orange
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
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            // Make the navigation bar background clear
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.isTranslucent = true
        }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Restore the navigation bar to default
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    // MARK: Do something
    func doSomething() {
        let request = AuthorizeUser.Something.Request()
        interactor?.doSomething(request: request)
    }
    func displaySomething(viewModel: AuthorizeUser.Something.ViewModel) {
        // nameTextField.text = viewModel.name
    }
    @IBAction func registerButtonClicked(_ sender: Any) {
        //self.router?.routeToRegister(segue: )
    }
    @IBAction func authorizeButtonClicked(_ sender: Any) {
        // let window = UIApplication.shared.keyWindow
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        transparentView.frame = self.view.frame
        // window?.addSubview(transparentView)
        self.view.addSubview(transparentView)
        let screenSize = UIScreen.main.bounds.size
        self.slideUpView.frame = CGRect(x: 0, y: screenSize.height,
                                        width: screenSize.width, height: screenSize.height/2)
        self.view.addSubview(slideUpView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClickTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.slideUpView.frame = CGRect(x: 0, y: screenSize.height/2,
            width: screenSize.width, height: screenSize.height/2)
        }, completion: nil)
    }
    @objc func onClickTransparentView() {
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.slideUpView.frame = CGRect(x: 0, y: screenSize.height,
                                           width: screenSize.width, height: screenSize.height/2)
            self.transparentView.alpha = 0
        }, completion: nil)
    }
}

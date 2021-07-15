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
        createCommonButton(button: registerButton, titleColor: UIColor.black, backgroundColor: UIColor.white, title: "Я новый пользователь")
        createCommonButton(button: authorizeButton, titleColor: UIColor.white, backgroundColor: UIColor.orange, title: "У меня уже есть аккаунт")
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
        
    }
    @IBAction func authorizeButtonClicked(_ sender: Any) {
       showMiracle()
    }
    
    @objc func showMiracle() {
        let slideVC = AuthorizeView()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
}

extension AuthorizeUserViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        AuthorizePresentationController(presentedViewController: presented, presenting: presenting)
    }
}

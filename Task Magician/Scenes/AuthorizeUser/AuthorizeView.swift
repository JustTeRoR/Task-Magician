//
//  AuthorizeView.swift
//  Task Magician
//
//  Created by Сергей Павленок on 15.07.2021.
//

import Foundation
import UIKit

class AuthorizeView: UIViewController {
    
    var interactor: AuthorizeUserBusinessLogic?
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    @IBOutlet var slideIndicator: UIView!
    @IBOutlet weak var loginTitleLable: UILabel!
    @IBOutlet weak var loginWarningLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
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
        viewController.interactor = interactor
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        setupViewUi()
    }
    
    func setupViewUi() {
        self.view.backgroundColor = UIColor.orange
        self.slideIndicator.roundCorners(.allCorners, radius: 10)
        self.loginTitleLable.text = "Войти"
        self.loginTitleLable.font = UIFont.boldSystemFont(ofSize: 22)
        self.loginTitleLable.textColor = UIColor.white
        self.loginWarningLabel.text = "(Не входите здесь, если у вас нет \n действующего аккаунта Task Magician)"
        self.loginWarningLabel.textColor = UIColor.white
        createVKButton(button: self.loginButton)
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
        print("Login session raised.")
        let request = AuthorizeUser.LoginUser.Request()
        interactor?.loginUser(request: request, authService: AppDelegate.shared().authService)
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
}

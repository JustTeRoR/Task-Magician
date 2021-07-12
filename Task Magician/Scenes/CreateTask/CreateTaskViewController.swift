//
//  CreateTaskViewController.swift
//  Task Magician
//
//  Created by Сергей Павленок on 12.07.2021.
//

import UIKit

protocol CreateTaskDisplayLogic: AnyObject
{
  func displaySomething(viewModel: CreateTask.Something.ViewModel)
}

class CreateTaskViewController: UIViewController, CreateTaskDisplayLogic
{
  var interactor: CreateTaskBusinessLogic?
  var router: (NSObjectProtocol & CreateTaskRoutingLogic & CreateTaskDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
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
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    doSomething()
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
  
  func doSomething()
  {
    let request = CreateTask.Something.Request()
    interactor?.doSomething(request: request)
  }
  
  func displaySomething(viewModel: CreateTask.Something.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
}

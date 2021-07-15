//
//  RegisterUserPresenter.swift
//  Task Magician
//

import UIKit

protocol RegisterUserPresentationLogic
{
  func presentSomething(response: RegisterUser.Something.Response)
}

class RegisterUserPresenter: RegisterUserPresentationLogic
{
  weak var viewController: RegisterUserDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: RegisterUser.Something.Response) {
    let viewModel = RegisterUser.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}

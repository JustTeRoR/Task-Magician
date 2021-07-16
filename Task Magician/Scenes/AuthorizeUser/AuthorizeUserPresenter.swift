//
//  AuthorizeUserPresenter.swift
//  Task Magician
//

import UIKit

protocol AuthorizeUserPresentationLogic
{
  func presentSomething(response: AuthorizeUser.Something.Response)
}

class AuthorizeUserPresenter: AuthorizeUserPresentationLogic
{
  weak var viewController: AuthorizeUserDisplayLogic?
  // MARK: Do something
    func presentSomething(response: AuthorizeUser.Something.Response) {
        let viewModel = AuthorizeUser.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}

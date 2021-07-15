//
//  AuthorizeUserInteractor.swift
//  Task Magician
//

import UIKit

protocol AuthorizeUserBusinessLogic {
    func doSomething(request: AuthorizeUser.Something.Request)
    func loginUser(request: AuthorizeUser.LoginUser.Request, authService: AuthService)
}

protocol AuthorizeUserDataStore {
  // var name: String { get set }
}

class AuthorizeUserInteractor: AuthorizeUserBusinessLogic, AuthorizeUserDataStore {
    var presenter: AuthorizeUserPresentationLogic?
    var worker: AuthorizeUserWorker?
    // var name: String = ""
    // MARK: Do something
    func doSomething(request: AuthorizeUser.Something.Request) {
        worker = AuthorizeUserWorker()
        worker?.doSomeWork()
        let response = AuthorizeUser.Something.Response()
        presenter?.presentSomething(response: response)
    }
    
    func loginUser(request: AuthorizeUser.LoginUser.Request, authService: AuthService) {
        worker = AuthorizeUserWorker()
        worker?.authorizePersonThroughVK(authService: authService)
        let response = AuthorizeUser.LoginUser.Response()
        // presenter?.presentSomething(response: response)
    }
}

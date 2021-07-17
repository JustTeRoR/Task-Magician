//
//  AuthorizeUserInteractor.swift
//  Task Magician
//

import UIKit

protocol AuthorizeUserBusinessLogic {
    func loginUser(request: AuthorizeUser.LoginUser.Request, authService: AuthService)
}

protocol AuthorizeUserDataStore {
  // var name: String { get set }
}

class AuthorizeUserInteractor: AuthorizeUserBusinessLogic, AuthorizeUserDataStore {
    var worker: AuthorizeUserWorker?
    
    func loginUser(request: AuthorizeUser.LoginUser.Request, authService: AuthService) {
        worker = AuthorizeUserWorker()
        worker?.authorizePersonThroughVK(authService: authService)
    }
}

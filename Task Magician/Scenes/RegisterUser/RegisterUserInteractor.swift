//
//  RegisterUserInteractor.swift
//  Task Magician
//

import UIKit

protocol RegisterUserBusinessLogic
{
    func registerPersonThroughVK(request: RegisterUser.RegisterUserProcess.Request, authService: AuthService)
}

protocol RegisterUserDataStore
{
  //var name: String { get set }
}

class RegisterUserInteractor: RegisterUserBusinessLogic, RegisterUserDataStore {
    var worker: RegisterUserWorker?
    
    func registerPersonThroughVK(request: RegisterUser.RegisterUserProcess.Request, authService: AuthService) {
        worker = RegisterUserWorker()
        worker?.registerPersonThroughVK(authService: authService)
    }
}

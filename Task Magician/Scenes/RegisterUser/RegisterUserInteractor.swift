//
//  RegisterUserInteractor.swift
//  Task Magician
//

import UIKit

protocol RegisterUserBusinessLogic
{
  func doSomething(request: RegisterUser.Something.Request)
}

protocol RegisterUserDataStore
{
  //var name: String { get set }
}

class RegisterUserInteractor: RegisterUserBusinessLogic, RegisterUserDataStore
{
  var presenter: RegisterUserPresentationLogic?
  var worker: RegisterUserWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: RegisterUser.Something.Request)
  {
    worker = RegisterUserWorker()
    worker?.doSomeWork()
    
    let response = RegisterUser.Something.Response()
    presenter?.presentSomething(response: response)
  }
}

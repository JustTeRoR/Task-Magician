//
//  CreateTaskInteractor.swift
//  Task Magician
//
//  Created by Сергей Павленок on 12.07.2021.
//

import UIKit

protocol CreateTaskBusinessLogic
{
  func doSomething(request: CreateTask.Something.Request)
}

protocol CreateTaskDataStore
{
  //var name: String { get set }
}

class CreateTaskInteractor: CreateTaskBusinessLogic, CreateTaskDataStore
{
  var presenter: CreateTaskPresentationLogic?
  var worker: CreateTaskWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: CreateTask.Something.Request)
  {
    worker = CreateTaskWorker()
    worker?.doSomeWork()
    
    let response = CreateTask.Something.Response()
    presenter?.presentSomething(response: response)
  }
}

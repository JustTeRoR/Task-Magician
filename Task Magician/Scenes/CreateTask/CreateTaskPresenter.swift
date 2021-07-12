//
//  CreateTaskPresenter.swift
//  Task Magician
//
//  Created by Сергей Павленок on 12.07.2021.
//

import UIKit

protocol CreateTaskPresentationLogic
{
  func presentSomething(response: CreateTask.Something.Response)
}

class CreateTaskPresenter: CreateTaskPresentationLogic
{
  weak var viewController: CreateTaskDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: CreateTask.Something.Response)
  {
    let viewModel = CreateTask.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}

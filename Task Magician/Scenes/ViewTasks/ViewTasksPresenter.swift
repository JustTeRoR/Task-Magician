//
//  ViewTasksPresenter.swift
//  Task Magician
//
//  Created by Сергей Павленок on 13.07.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ViewTasksPresentationLogic
{
    func presentUserInfo(response: ViewTasks.GetUserInfo.Response.ResponseType)
    func presentSomething(response: ViewTasks.Something.Response)
}

class ViewTasksPresenter: ViewTasksPresentationLogic {
    typealias ViewModelAlias = ViewTasks.GetUserInfo.ViewModel.ViewModelData
    weak var viewController: ViewTasksDisplayLogic?
  
    let dateFormatter: DateFormatter = {
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "ru_RU")
        dateFormater.dateFormat = "d MMM 'в' HH:mm"
        return dateFormater
    }()
  
    func presentUserInfo(response: ViewTasks.GetUserInfo.Response.ResponseType) {
        switch response {
        case .presentUserInfo(let user):
            let userViewModel = UserViewModel.init(photoUrlString: user?.photo100, name: user!.name)
            viewController?.displayUserData(viewModel: ViewModelAlias.displayUser(userViewModel: userViewModel))
        }

    }
    
    func presentSomething(response: ViewTasks.Something.Response) {
        let viewModel = ViewTasks.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}

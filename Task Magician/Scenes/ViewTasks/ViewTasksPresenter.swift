//
//  ViewTasksPresenter.swift
//  Task Magician
//
//  Created by Сергей Павленок on 13.07.2021.
//

import UIKit

protocol ViewTasksPresentationLogic {
    func presentUserInfo(response: ViewTasks.UserOperations.Response.ResponseType)
}

class ViewTasksPresenter: ViewTasksPresentationLogic {
    typealias ViewModelAlias = ViewTasks.UserOperations.ViewModel.ViewModelData
    weak var viewController: ViewTasksDisplayLogic?
  
    let dateFormatter: DateFormatter = {
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "ru_RU")
        dateFormater.dateFormat = "d MMM 'в' HH:mm"
        return dateFormater
    }()
  
    func presentUserInfo(response: ViewTasks.UserOperations.Response.ResponseType) {
        switch response {
        case .presentUserInfo(let user):
            let userViewModel = UserViewModel.init(photoUrlString: user?.photo100, name: user!.name)
            viewController?.displayUserData(viewModel: ViewModelAlias.displayUser(userViewModel: userViewModel))
        }

    }
}

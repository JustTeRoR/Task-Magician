//
//  ViewTasksInteractor.swift
//  Task Magician
//
//  Created by Сергей Павленок on 13.07.2021.
//

import UIKit

protocol ViewTasksBusinessLogic {
    func makeRequest(request: ViewTasks.UserOperations.Request.RequestType)
}

protocol ViewTasksDataStore {
  //var name: String { get set }
}

class ViewTasksInteractor: ViewTasksBusinessLogic, ViewTasksDataStore {
    typealias ResponseTypeAlias = ViewTasks.UserOperations.Response.ResponseType
    var presenter: ViewTasksPresentationLogic?
    var worker: ViewTasksWorker?
    var service: MainService?
    
    func makeRequest(request: ViewTasks.UserOperations.Request.RequestType) {
        if service == nil {
            service = MainService()
        }
        switch request {
        case .getUser:
            service?.getUser(completion: { [weak self] (user) in
                self?.presenter?.presentUserInfo(response:
                                                    ResponseTypeAlias.presentUserInfo(user: user))
            })
        }
    }
}

//
//  ViewTasksInteractor.swift
//  Task Magician
//
//  Created by Сергей Павленок on 13.07.2021.
//

import UIKit

protocol ViewTasksBusinessLogic
{
    func doSomething(request: ViewTasks.Something.Request)
    func makeRequest(request: ViewTasks.GetUserInfo.Request.RequestType)
}

protocol ViewTasksDataStore
{
  //var name: String { get set }
}

class ViewTasksInteractor: ViewTasksBusinessLogic, ViewTasksDataStore {
    typealias ResponseTypeAlias = ViewTasks.GetUserInfo.Response.ResponseType
    var presenter: ViewTasksPresentationLogic?
    var worker: ViewTasksWorker?
    var service: MainService?
  
    // MARK: Do something
    func doSomething(request: ViewTasks.Something.Request) {
        worker = ViewTasksWorker()
        worker?.doSomeWork()
        let response = ViewTasks.Something.Response()
        presenter?.presentSomething(response: response)
    }
    
    func makeRequest(request: ViewTasks.GetUserInfo.Request.RequestType) {
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

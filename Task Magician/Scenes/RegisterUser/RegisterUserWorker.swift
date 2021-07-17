//
//  RegisterUserWorker.swift
//  Task Magician
//

import UIKit
import Foundation
import RealmSwift

class RegisterUserWorker {
    func registerPersonThroughVK(authService: AuthService) {
        //To think how to wait until vk login will be finished and after that getUser and perform login to Realm
        let service = MainService()
        var name: AnyBSON = .string("")
        authService.wakeUpSession()
        
        service.getUser { (user) in
            name = .string(user!.name)
        }
        
        let paramss: Document = ["name": name]
        let params: Document = ["name": "Андрей Павленок"]
        app.login(credentials: Credentials.function(payload: params)) { (result) in
            switch result {
            case .failure(let error):
                print("Login failed: \(error.localizedDescription)")
            case .success(let user):
                print("Successfully logged in as user with id \(user.id)")
                user.configuration(partitionValue: "user=\(user.id)")
            }
        }
    }
}

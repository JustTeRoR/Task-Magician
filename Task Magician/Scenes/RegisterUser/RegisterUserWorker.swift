//
//  RegisterUserWorker.swift
//  Task Magician
//

import UIKit
import RealmSwift

class RegisterUserWorker {    
    func registerPersonThroughVK(authService: AuthService) {
        authService.wakeUpSession()
        
       
        let params: Document = ["name": "Андрей Павленок"]
        
        app.login(credentials: Credentials.function(payload: params)) { (result) in
            switch result {
            case .failure(let error):
                print("Login failed: \(error.localizedDescription)")
            case .success(let user):
                print("Successfully logged in as user \(user)")
                user.configuration(partitionValue: "user=\(user.id)")
                
                // Now logged in, do something with user
                // Remember to dispatch to main if you are doing anything on the UI thread
            }
        }
    }
}

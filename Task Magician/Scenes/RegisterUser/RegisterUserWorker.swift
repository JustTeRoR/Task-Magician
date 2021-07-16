//
//  RegisterUserWorker.swift
//  Task Magician
//

import UIKit

class RegisterUserWorker {    
    func registerPersonThroughVK(authService: AuthService) {
        authService.wakeUpSession()
    }
}

//
//  AuthorizeUserWorker.swift
//  Task Magician
//

import UIKit

class AuthorizeUserWorker
{
    func doSomeWork() {
    }
    
    func authorizePersonThroughVK(authService: AuthService) {
        authService.wakeUpSession()
    }
}

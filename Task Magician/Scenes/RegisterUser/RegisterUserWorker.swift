//
//  RegisterUserWorker.swift
//  Task Magician
//

import UIKit
import Foundation
import RealmSwift
import VK_ios_sdk

class RegisterUserWorker {
    func registerPersonThroughVK(authService: AuthService) {
        authService.wakeUpSession()
    }
}

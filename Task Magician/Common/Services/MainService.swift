//
//  MainService.swift
//  Task Magician
//
//  Created by Сергей Павленок on 12.07.2021.
//

import Foundation

class MainService {
    var authService: AuthService
    var networking: Networking
    var fetcher: DataFetcher
    
    init() {
        self.authService = AppDelegate.shared().authService
        self.networking = NetworkService(authService: authService)
        self.fetcher = NetworkDataFetcher(networking: networking)
    }

    func getUser(completion: @escaping (UserResponse?) -> Void) {
        fetcher.getUser { (userResponse) in
            completion(userResponse)
        }
    }
}

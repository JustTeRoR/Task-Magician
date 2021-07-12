//
//  NetworkDataFetcher.swift
//  Task Magician
//
//  Created by Сергей Павленок on 12.07.2021.
//

import Foundation

protocol DataFetcher {
    func getUser(response: @escaping (UserResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    
    private let authService: AuthService
    let networking: Networking
    
    init(networking: Networking, authService: AuthService = AppDelegate.shared().authService) {
        self.networking = networking
        self.authService = authService
    }
    
    func getUser(response: @escaping (UserResponse?) -> Void) {
        guard let userId = authService.userId else { return }
        let params = ["user_ids": userId, "fields": "photo_100"]
        networking.request(path: API.user, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            
            let decoded = self.decodeJSON(type: UserResponseWrapped.self, from: data)
            response(decoded?.response.first)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}

//
//  UserResponse.swift
//  Task Magician
//
//  Created by Сергей Павленок on 12.07.2021.
//

import Foundation

struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String?
}

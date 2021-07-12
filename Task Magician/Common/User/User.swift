//
//  User.swift
//  Task Magician
//
//  Created by Сергей Павленок on 12.07.2021.
//

import Foundation
import RealmSwift

class User: Object {
    // MARK: maybe it's better to use id for users same as in VK API
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var surname: String = ""
    override static func primaryKey() -> String? {
        return "id"
    }
}

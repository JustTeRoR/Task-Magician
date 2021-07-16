//
//  User.swift
//  Task Magician
//
//  Created by Сергей Павленок on 12.07.2021.
//

import Foundation
import RealmSwift

// swiftlint:disable identifier_name
class User: Object {
    @Persisted(primaryKey: true) var _id: String = ""
    @Persisted var name: String = ""
}

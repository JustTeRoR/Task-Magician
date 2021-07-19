//
//  Subtask.swift
//  Task Magician
//
//  Created by Сергей Павленок on 19.07.2021.
//

import Foundation
import RealmSwift
// swiftlint:disable identifier_name

class Subtask: EmbeddedObject {
    @Persisted var name: String = ""
    @Persisted var isCompleted: Bool = false
    @Persisted var owner: String?
    
    convenience init(name: String, owner: String?) {
        self.init()
        self.name = name
        self.owner = owner
    }
}

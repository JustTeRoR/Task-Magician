//
//  Task.swift
//  Task Magician
//
//  Created by Сергей Павленок on 16.07.2021.
//

import Foundation
import RealmSwift

// swiftlint:disable identifier_name
enum TaskStatus: String, CaseIterable {
    case Open = "Не начато"
    case InProgress = "В процессе"
    case OnHold = "На удерживании"
    case Completed = "Выполнено"
}

enum TaskGroup: String, CaseIterable {
    case Private = "Личные"
    case Work = "Рабочие"
    case Shopping = "Покупки"
    case Assignments = "Поручения"
}

class Task: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var owner: String?
    @Persisted var status: String = ""
    @Persisted var deadline: Date = Date()
    @Persisted var taskDescription: String?
    @Persisted var group: String = ""
    @Persisted var isCompleted: Bool = false
    @Persisted var listOfSubtasks: RealmSwift.List<Subtask>
    
    var statusEnum: TaskStatus {
        get {
            return TaskStatus(rawValue: status) ?? .Open
        }
        set {
            status = newValue.rawValue
        }
    }

    var groupEnum: TaskGroup {
        get {
            return TaskGroup(rawValue: group) ?? .Private
        }
        set {
            group = newValue.rawValue
        }
    }
    
    convenience init(name: String, status: TaskStatus, group: TaskGroup,
                     description: String?, owner: String?, deadline: Date) {
        self.init()
        self.name = name
        self.status = status.rawValue
        self.group = group.rawValue
        self.taskDescription = description
        self.owner = owner
        self.deadline = deadline
    }
}

extension Task: Identifiable {
    var id: String {
        _id.stringValue
    }
}

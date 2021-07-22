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

class Task: Object, Codable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var owner: String?
    @Persisted var status: String = ""
    @Persisted var deadline: Date = Date()
    @Persisted var taskDescription: String?
    @Persisted var group: String = ""
    @Persisted var isCompleted: Bool = false
    @Persisted var listOfSubtasks: RealmSwift.List<Subtask>
    
    private enum CodingKeys: String, CodingKey {
        case name
        case owner
        case status
        case deadline
        case taskDescription
        case group
        case isCompleted
        case listOfSubtasks
    }

    
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
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(owner, forKey: .owner)
        try container.encode(status, forKey: .status)
        try container.encode(deadline, forKey: .deadline)
        try container.encode(taskDescription, forKey: .taskDescription)
        try container.encode(group, forKey: .group)
        try container.encode(isCompleted, forKey: .isCompleted)
        let subtaskArray = Array(self.listOfSubtasks)
        try container.encode(subtaskArray, forKey: .listOfSubtasks)
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decode(String.self, forKey: .name)
        self.owner = try values.decode(String.self, forKey: .owner)
        self.status = try values.decode(String.self, forKey: .status)
        self.deadline = try values.decode(Date.self, forKey: .deadline)
        self.taskDescription = try values.decode(String.self, forKey: .taskDescription)
        self.group = try values.decode(String.self, forKey: .group)
        self.isCompleted = try values.decode(Bool.self, forKey: .isCompleted)
        let subtaskArray = try values.decode([Subtask].self, forKey: .listOfSubtasks)
        self.listOfSubtasks.append(objectsIn: subtaskArray)
       
    }
}

extension Task: Identifiable {
    var id: String {
        _id.stringValue
    }
}

// MARK: - Exporting/Importing
extension Task {
    func exportToURL() -> URL? {
      guard let encoded = try? JSONEncoder().encode(self) else { return nil }
      
      let documents = FileManager.default.urls(
        for: .documentDirectory,
        in: .userDomainMask
      ).first
      
      guard let path = documents?.appendingPathComponent("/\(name).tmag") else {
        return nil
      }
      
      do {
        try encoded.write(to: path, options: .atomicWrite)
        return path
      } catch {
        print(error.localizedDescription)
        return nil
      }
    }
    
    static func importData(from url: URL) -> Task? {
      guard
        let data = try? Data(contentsOf: url),
        let task = try? JSONDecoder().decode(Task.self, from: data)
        else { return nil }
        try? FileManager.default.removeItem(at: url)
        return task
    }
}


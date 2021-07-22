//
//  Subtask.swift
//  Task Magician
//
//  Created by Сергей Павленок on 19.07.2021.
//

import Foundation
import RealmSwift

class Subtask: EmbeddedObject, Codable {
    @Persisted var name: String = ""
    @Persisted var isCompleted: Bool = false
    @Persisted var owner: String?
    
    convenience init(name: String, owner: String?) {
        self.init()
        self.name = name
        self.owner = owner
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case isCompleted
        case owner
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(isCompleted, forKey: .isCompleted)
        try container.encode(owner, forKey: .owner)
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let name = try values.decode(String.self, forKey: .name)
        let isCompleted = try values.decode(Bool.self, forKey: .isCompleted)
        let owner = try values.decode(String.self, forKey: .owner)
    }
}

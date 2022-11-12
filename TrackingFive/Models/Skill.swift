//
//  Skill.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/12/22.
//

import Foundation

struct Skill: Identifiable, Hashable {
    let id: String
    
    var name: String
    var rules: String?
    
    init(id: String = UUID().uuidString, name: String, rules: String? = nil) {
        self.id = id
        self.name = name
        self.rules = rules
    }
}

extension Skill {
    static let designMock = Skill(name: "Battlewise", rules: "+2 to Battlewise tests")
}

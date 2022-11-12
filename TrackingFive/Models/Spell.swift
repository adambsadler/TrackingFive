//
//  Spell.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/12/22.
//

import Foundation

struct Spell: Identifiable, Hashable {
    let id: String
    
    var name: String
    var incantation: Int
    var rules: String?
    
    init(id: String = UUID().uuidString, name: String, incantation: Int = 0, rules: String? = nil) {
        self.id = id
        self.name = name
        self.incantation = incantation
        self.rules = rules
    }
}

extension Spell {
    static let designMock = Spell(name: "Heal", incantation: 6, rules: "Remove wounded from an ally.")
}

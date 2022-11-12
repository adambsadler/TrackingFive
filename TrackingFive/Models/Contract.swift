//
//  Contract.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/12/22.
//

import Foundation

struct Contract: Identifiable, Hashable {
    let id: String
    
    var name: String
    var reward: String?
    var rules: String?
    
    init(id: String = UUID().uuidString, name: String, reward: String? = nil, rules: String? = nil) {
        self.id = id
        self.name = name
        self.reward = reward
        self.rules = rules
    }
}

extension Contract {
    static let designMock = Contract(name: "Locate item", reward: "3 Gold Marks", rules: "Defeate a Unique Foe in melee combat. Find item on 5+.")
}

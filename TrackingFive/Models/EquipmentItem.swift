//
//  EquipmentItem.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/12/22.
//

import Foundation

struct EquipmentItem: Identifiable, Hashable {
    let id: String
    
    var name: String
    var rules: String?
    
    init(id: String = UUID().uuidString, name: String, rules: String? = nil) {
        self.id = id
        self.name = name
        self.rules = rules
    }
}

extension EquipmentItem {
    static let designMock = EquipmentItem(name: "2 Silvertree leaf (S,C)", rules: "Reroll post-game Injuries.")
}

//
//  Weapon.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/12/22.
//

import Foundation

enum WeaponType {
    case melee
    case ranged
}

struct Weapon: Identifiable, Hashable {
    let id: String
    
    var name: String
    var type: WeaponType
    var overcomeArmor: Int
    var overcomeToughness: Int
    var rules: String?
    
    init(id: String = UUID().uuidString, name: String, type: WeaponType, overcomeArmor: Int, overcomeToughness: Int, rules: String? = nil) {
        self.id = id
        self.name = name
        self.type = type
        self.overcomeArmor = overcomeArmor
        self.overcomeToughness = overcomeToughness
        self.rules = rules
    }
}

extension Weapon {
    static let designMock = Weapon(name: "Bastard sword", type: .melee, overcomeArmor: 0, overcomeToughness: 1)
}

//
//  Follower.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/12/22.
//

import Foundation

struct Follower: Identifiable, Hashable {
    let id: String
    
    var name: String
    var origin: Origin
    var agility: Int
    var speed: Int
    var dashSpeed: Int
    var combatSkill: Int
    var toughness: Int
    var luck: Int
    var will: Int
    var casting: Int
    var skills: [Skill]
    var weapons: [Weapon]
    var armor: Armor?
    var items: [EquipmentItem]
    
    init(id: String = UUID().uuidString, name: String) {
        self.id = id
        self.name = name
        self.origin = .human
        self.agility = 1
        self.speed = 4
        self.dashSpeed = 3
        self.combatSkill = 0
        self.toughness = 3
        self.luck = 0
        self.will = 0
        self.casting = 0
        self.skills = []
        self.weapons = []
        self.armor = nil
        self.items = []
    }
}

extension Follower {
    static let designMock = Follower(name: "Guyver")
}

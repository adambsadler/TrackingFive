//
//  Warband.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/12/22.
//

import Foundation

struct Warband: Identifiable, Hashable {
    let id: String
    
    var name: String
    var region: String?
    var currentLocation: String?
    var goldMarks: Int
    var storyPoints: Int
    var adventurePoints: Int
    var stashedItems: [EquipmentItem]
    var stashedWeapons: [Weapon]
    var stashedArmor: [Armor]
    var itemsInBackpack: [EquipmentItem]
    var weaponsInBackpack: [Weapon]
    var armorInBackpack: [Armor]
    var heroes: [Hero]
    var followers: [Follower]
    var threats: [Threat]
    var friends: [String]
    var quest: Quest?
    var contract: [Contract]
    var notes: [String]
    
    init(id: String = UUID().uuidString, name: String) {
        self.id = id
        self.name = name
        self.region = nil
        self.currentLocation = nil
        self.goldMarks = 0
        self.storyPoints = 0
        self.adventurePoints = 0
        self.stashedItems = []
        self.stashedWeapons = []
        self.stashedArmor = []
        self.itemsInBackpack = []
        self.weaponsInBackpack = []
        self.armorInBackpack = []
        self.heroes = []
        self.followers = []
        self.threats = []
        self.friends = []
        self.quest = nil
        self.contract = []
        self.notes = []
    }
}

extension Warband {
    static let designMock = Warband(name: "The Brightguard")
}

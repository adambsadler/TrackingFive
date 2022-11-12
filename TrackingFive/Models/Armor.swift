//
//  Armor.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/12/22.
//

import Foundation

struct Armor: Identifiable, Hashable {
    let id: String
    
    var name: String
    var rating: Int
    var rules: String?
    
    init(id: String = UUID().uuidString, name:String, rating: Int, rules: String? = nil) {
        self.id = id
        self.name = name
        self.rating = rating
        self.rules = rules
    }
}

extension Armor {
    static let designMock = Armor(name: "Partial armor", rating: 2, rules: "Movement reduced by 0/-2")
}

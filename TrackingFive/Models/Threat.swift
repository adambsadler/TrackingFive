//
//  Threat.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/12/22.
//

import Foundation

struct Threat: Identifiable, Hashable {
    let id: String
    
    var name: String
    var level: Int
    
    init(id: String = UUID().uuidString, name: String, level: Int) {
        self.id = id
        self.name = name
        self.level = level
    }
}

extension Threat {
    static let designMock = Threat(name: "The Ruin Within", level: 5)
}

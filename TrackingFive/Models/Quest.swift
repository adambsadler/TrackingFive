//
//  Quest.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/12/22.
//

import Foundation

struct Quest: Identifiable, Hashable {
    let id: String
    
    var task: String
    var location: String?
    var rules: String?
    
    init(id: String = UUID().uuidString, task: String, location: String? = nil, rules: String? = nil) {
        self.id = id
        self.task = task
        self.location = location
        self.rules = rules
    }
}

extension Quest {
    static let designMock = Quest(task: "Rescue the prisoner", location: "Wilderness", rules: "Fight a Raid(Camp) scenario.")
}

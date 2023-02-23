//
//  CharacterType.swift
//  TrackingFive
//
//  Created by Adam Sadler on 2/23/23.
//

import Foundation
import SwiftUI

enum CharacterType: String, Equatable, CaseIterable {
    case hero = "Hero"
    case follower = "Follower"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}

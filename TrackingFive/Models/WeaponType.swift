//
//  WeaponType.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/13/22.
//

import Foundation
import SwiftUI

enum WeaponType: String, Equatable, CaseIterable {
    case melee = "Melee"
    case ranged = "Ranged"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}

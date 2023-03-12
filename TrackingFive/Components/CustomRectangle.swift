//
//  CustomRectangle.swift
//  TrackingFive
//
//  Created by Adam Sadler on 3/11/23.
//

import Foundation
import SwiftUI

struct CustomRectangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX + rect.width, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX + 0.85 * rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + rect.height))
        path.closeSubpath()
        return path
    }
}

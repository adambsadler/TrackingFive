//
//  CustomButton.swift
//  TrackingFive
//
//  Created by Adam Sadler on 3/12/23.
//

import SwiftUI

enum ButtonSize {
    case medium
    case small
}

enum ButtonStyle {
    case active
    case inactive
    case cancel
}

struct CustomButton: View {
    var text: String
    var size: ButtonSize
    var style: ButtonStyle
    var action: () -> Void
    var buttonPadding: CGFloat {
        switch size {
        case .medium:
            return 15
        case .small:
            return 8
        }
    }
    var textColor: Color {
        switch style {
        case .active:
            return Color("BlackWhite")
        case .inactive:
            return Color.white
        case .cancel:
            return Color.white
        }
    }
    var buttonColor: Color {
        switch style {
        case .active:
            return Color.accentColor
        case .inactive:
            return Color.gray
        case .cancel:
            return Color.red
        }
    }
    var buttonCorner: CGFloat {
        switch size {
        case .medium:
            return 15
        case .small:
            return 10
        }
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .padding(buttonPadding)
                .foregroundColor(textColor)
                .background(buttonColor)
                .cornerRadius(buttonCorner)
        }
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(text: "Button", size: .small, style: .active, action: { })
    }
}

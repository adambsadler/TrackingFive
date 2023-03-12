//
//  HeaderView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 3/11/23.
//

import SwiftUI

enum HeaderSize {
    case large
    case largeFlipped
    case medium
}

struct HeaderView: View {
    var size: HeaderSize
    var text: String
    var widthPercentage: Double
    var height: CGFloat
    
    var body: some View {
        ZStack {
            switch size {
            case .large:
                HStack {
                    CustomRectangle()
                        .fill(Color("LightGreen"))
                        .frame(width: UIScreen.main.bounds.width * widthPercentage, height: height)
                        .shadow(radius: 10)
                    Spacer()
                }
                Text(text)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
            case .largeFlipped:
                HStack {
                    Spacer()
                    CustomRectangle()
                        .fill(Color("LightGreen"))
                        .frame(width: UIScreen.main.bounds.width * widthPercentage, height: height)
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                        .shadow(radius: 10)
                }
                Text("Choose a Game")
                    .font(.title)
                    .fontWeight(.bold)
            case .medium:
                HStack {
                    CustomRectangle()
                        .fill(Color("LightGreen"))
                        .frame(width: UIScreen.main.bounds.width * widthPercentage, height: height)
                        .shadow(radius: 8)
                    Spacer()
                }
                
                HStack {
                    Text(text)
                        .font(.headline)
                        .fontWeight(.heavy)
                    Spacer()
                }
                .padding(.leading)
                
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(size: .large, text: "Sample Header", widthPercentage: 0.75, height: 60)
    }
}

//
//  CharacterListView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 2/23/23.
//

import SwiftUI

struct CharacterListView: View {
    let name: String
    let type: CharacterType
    let agility: Int
    let speed: Int
    let dash: Int
    let combat: Int
    let toughness: Int
    
    var body: some View {
        VStack {
            HStack {
                Text(name)
                    .bold()
                Spacer()
                Text(type.localizedName)
                    .bold()
            }
            .padding()
            
            HStack(spacing: 25) {
                VStack {
                    Text("Agility")
                        .bold()
                    Text("\(agility)")
                }
                
                VStack {
                    Text("Speed")
                        .bold()
                    Text("\(speed)\" / +\(dash)\"")
                }
                
                VStack {
                    Text("Combat")
                        .bold()
                    Text("+\(combat)")
                }
                
                VStack {
                    Text("Tough")
                        .bold()
                    Text("\(toughness)")
                }
            }
            .padding(.bottom)
        }
        .background(.tertiary)
        .cornerRadius(15)
        .padding()
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView(name: "Valten", type: .hero, agility: 2, speed: 6, dash: 3, combat: 1, toughness: 3)
    }
}

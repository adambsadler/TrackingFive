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
                    .foregroundColor(.white)
                    .bold()
                Spacer()
                Text(type.localizedName)
                    .foregroundColor(.white)
                    .bold()
            }
            .padding()
            
            HStack(spacing: 25) {
                VStack {
                    Text("Agility")
                        .foregroundColor(.white)
                        .bold()
                    Text("\(agility)")
                        .foregroundColor(.white)
                }
                
                VStack {
                    Text("Speed")
                        .foregroundColor(.white)
                        .bold()
                    Text("\(speed)\" / +\(dash)\"")
                        .foregroundColor(.white)
                }
                
                VStack {
                    Text("Combat")
                        .foregroundColor(.white)
                        .bold()
                    Text("+\(combat)")
                        .foregroundColor(.white)
                }
                
                VStack {
                    Text("Tough")
                        .foregroundColor(.white)
                        .bold()
                    Text("\(toughness)")
                        .foregroundColor(.white)
                }
            }
            .padding(.bottom)
        }
        .background(.gray)
        .cornerRadius(15)
        .padding()
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView(name: "Valten", type: .hero, agility: 2, speed: 6, dash: 3, combat: 1, toughness: 3)
    }
}

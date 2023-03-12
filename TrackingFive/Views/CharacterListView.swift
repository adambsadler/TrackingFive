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
                    .foregroundColor(Color("BlackWhite"))
                    .bold()
                Spacer()
                Text(type.localizedName)
                    .foregroundColor(Color("BlackWhite"))
                    .bold()
            }
            .padding()
            
            HStack(spacing: 25) {
                VStack {
                    Text("Agility")
                        .foregroundColor(Color("BlackWhite"))
                        .bold()
                    Text("\(agility)")
                        .foregroundColor(Color("BlackWhite"))
                }
                
                VStack {
                    Text("Speed")
                        .foregroundColor(Color("BlackWhite"))
                        .bold()
                    Text("\(speed)\" / +\(dash)\"")
                        .foregroundColor(Color("BlackWhite"))
                }
                
                VStack {
                    Text("Combat")
                        .foregroundColor(Color("BlackWhite"))
                        .bold()
                    Text("+\(combat)")
                        .foregroundColor(Color("BlackWhite"))
                }
                
                VStack {
                    Text("Tough")
                        .foregroundColor(Color("BlackWhite"))
                        .bold()
                    Text("\(toughness)")
                        .foregroundColor(Color("BlackWhite"))
                }
            }
            .padding(.bottom)
        }
        .background(Color("LightGreen"))
        .cornerRadius(15)
        .padding()
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView(name: "Valten", type: .hero, agility: 2, speed: 6, dash: 3, combat: 1, toughness: 3)
    }
}

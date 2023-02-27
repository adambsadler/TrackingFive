//
//  CharacterDetailView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 2/24/23.
//

import SwiftUI

struct CharacterDetailView: View {
    var type: CharacterType
    var name: String
    var origin: String
    var agility: Int
    var speed: Int
    var dash: Int
    var combat: Int
    var toughness: Int
    var luck: Int
    var will: Int
    var casting: Int
    var experience: Int
    
    var body: some View {
        VStack {
            HStack {
                Text("Name: ")
                    .fontWeight(.bold)
                Text(name)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 5)
            
            if type == .hero {
                HStack {
                    Text("Origin: ")
                        .fontWeight(.bold)
                    Text(origin)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom, 5)
            }
            
            HStack {
                Text("Agility: ")
                    .fontWeight(.bold)
                Text("\(agility)")
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
            
            HStack {
                Text("Speed: ")
                    .fontWeight(.bold)
                Text("\(speed)\" / + \(dash)\"")
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
            
            HStack {
                Text("Combat: ")
                    .fontWeight(.bold)
                Text("+ \(combat)")
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
            
            HStack {
                Text("Toughness: ")
                    .fontWeight(.bold)
                Text("\(toughness)")
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
            
            HStack {
                Text("Luck: ")
                    .fontWeight(.bold)
                Text("\(luck)")
                    .padding(.trailing)
                
                Text("Will: ")
                    .fontWeight(.bold)
                    .padding(.leading)
                Text("\(will)")
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
            
            if type == .hero {
                HStack {
                    Text("Casting: ")
                        .fontWeight(.bold)
                    Text("+ \(casting)")
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
                
                HStack {
                    Text("Experience: ")
                        .fontWeight(.bold)
                    Text("\(experience)")
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
            }
        }
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(type: .hero, name: "Valten", origin: "Human", agility: 2, speed: 6, dash: 3, combat: 1, toughness: 3, luck: 1, will: 1, casting: 0, experience: 0)
    }
}

//
//  EditHeroView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 2/24/23.
//

import SwiftUI

struct EditHeroView: View {
    @ObservedObject var warbandVM: WarbandViewModel
    @ObservedObject var hero: Hero
    @Binding var isEditing: Bool
    @State var name: String = ""
    @State var origin: String = ""
    @State var agility: Int = 0
    @State var speed: Int = 0
    @State var dash: Int = 0
    @State var combat: Int = 0
    @State var toughness: Int = 0
    @State var luck: Int = 0
    @State var will: Int = 0
    @State var casting: Int = 0
    @State var experience: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("Name: ")
                    .fontWeight(.bold)
                TextField("Hero Name", text: $name)
                    .disableAutocorrection(true)
            }
            .padding(.horizontal)
            
            HStack {
                Text("Origin: ")
                    .fontWeight(.bold)
                TextField("Hero Origin", text: $origin)
                    .disableAutocorrection(true)
            }
            .padding(.horizontal)
            
            HStack {
                Text("Agility: ")
                    .fontWeight(.bold)
                Picker("Agility", selection: $agility) {
                    ForEach(0 ..< 5) {
                        Text("\($0)")
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Text("Speed: ")
                    .fontWeight(.bold)
                Picker("Speed", selection: $speed) {
                    ForEach(0 ..< 8) {
                        Text("\($0)")
                    }
                }
                Text("/ +")
                Picker("Dash", selection: $dash) {
                    ForEach(0 ..< 5) {
                        Text("\($0)")
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Text("Combat: ")
                    .fontWeight(.bold)
                Picker("Combat", selection: $combat) {
                    ForEach(0 ..< 4) {
                        Text("\($0)")
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Text("Toughness: ")
                    .fontWeight(.bold)
                Picker("Toughness", selection: $toughness) {
                    ForEach(0 ..< 7) {
                        Text("\($0)")
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Text("Luck: ")
                    .fontWeight(.bold)
                Picker("Luck", selection: $luck) {
                    ForEach(0 ..< 7) {
                        Text("\($0)")
                    }
                }
                
                Text("Will: ")
                    .fontWeight(.bold)
                Picker("Will", selection: $will) {
                    ForEach(0 ..< 7) {
                        Text("\($0)")
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Text("Casting: ")
                    .fontWeight(.bold)
                Picker("Casting", selection: $casting) {
                    ForEach(0 ..< 4) {
                        Text("\($0)")
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Text("Experience: ")
                    .fontWeight(.bold)
                TextField("Experience", value: $experience, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                Spacer()
            }
            .padding(.horizontal)
            
            Button {
                warbandVM.updateHero(hero: hero, name: name, origin: origin, agility: agility, speed: speed, dash: dash, combat: combat, toughness: toughness, luck: luck, will: will, casting: casting, experience: experience)
                isEditing.toggle()
            } label: {
                Text("Update Hero")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.accentColor)
                    .cornerRadius(15)
            }
            .padding()
            
        }
        .onAppear {
            name = hero.name ?? ""
            origin = hero.origin ?? ""
            agility = Int(hero.agility)
            speed = Int(hero.speed)
            dash = Int(hero.dashSpeed)
            combat = Int(hero.combatSkill)
            toughness = Int(hero.toughness)
            luck = Int(hero.luck)
            will = Int(hero.will)
            casting = Int(hero.casting)
            experience = Int(hero.experience)
        }
    }
}

struct EditHeroView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let previewWarband = Warband(context: viewContext)
        previewWarband.name = "The Brightguard"
        let previewHero = Hero(context: viewContext)
        previewHero.name = "Valten"
        previewHero.origin = "Human"
        
        return EditHeroView(warbandVM: WarbandViewModel(), hero: previewHero, isEditing: .constant(true))
    }
}

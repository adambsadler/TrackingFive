//
//  EditFollowerView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 2/26/23.
//

import SwiftUI

struct EditFollowerView: View {
    @ObservedObject var warbandVM: WarbandViewModel
    @ObservedObject var follower: Follower
    @Binding var isEditing: Bool
    @State var name: String = ""
    @State var agility: Int = 0
    @State var speed: Int = 0
    @State var dash: Int = 0
    @State var combat: Int = 0
    @State var toughness: Int = 0
    @State var luck: Int = 0
    @State var will: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("Name: ")
                    .fontWeight(.bold)
                TextField("Follower Name", text: $name)
                    .disableAutocorrection(true)
            }
            .padding(.horizontal)
            
            HStack {
                Text("Agility: ")
                    .fontWeight(.bold)
                Picker("Agility", selection: $agility) {
                    ForEach(0 ..< 5, id: \.self) {
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
                    ForEach(0 ..< 8, id: \.self) {
                        Text("\($0)")
                    }
                }
                Text("/ +")
                Picker("Dash", selection: $dash) {
                    ForEach(0 ..< 5, id: \.self) {
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
                    ForEach(0 ..< 4, id: \.self) {
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
                    ForEach(0 ..< 7, id: \.self) {
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
                    ForEach(0 ..< 7, id: \.self) {
                        Text("\($0)")
                    }
                }
                
                Text("Will: ")
                    .fontWeight(.bold)
                Picker("Will", selection: $will) {
                    ForEach(0 ..< 7, id: \.self) {
                        Text("\($0)")
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
            
            CustomButton(text: "Update Follower", size: .medium, style: .active) {
                warbandVM.updateFollower(follower: follower, name: name, agility: agility, speed: speed, dash: dash, combat: combat, toughness: toughness, luck: luck, will: will)
                isEditing.toggle()
            }
            .padding()
            
        }
        .onAppear {
            name = follower.name ?? ""
            agility = Int(follower.agility)
            speed = Int(follower.speed)
            dash = Int(follower.dashSpeed)
            combat = Int(follower.combatSkill)
            toughness = Int(follower.toughness)
            luck = Int(follower.luck)
            will = Int(follower.will)
        }
    }
}

struct EditFollowerView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let previewWarband = Warband(context: viewContext)
        previewWarband.name = "The Brightguard"
        let previewFollower = Follower(context: viewContext)
        previewFollower.name = "Guyver"
        
        return EditFollowerView(warbandVM: WarbandViewModel(), follower: previewFollower, isEditing: .constant(true))
    }
}

//
//  ArmorDetailView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 2/25/23.
//

import SwiftUI

struct ArmorDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var warbandVM: WarbandViewModel
    @ObservedObject var armor: Armor
    @State var isMovingArmor: Bool = false
    @State var isMovingToBackpack: Bool = false
    @State var isMovingToStash: Bool = false
    @State var isMovingToHero: Bool = false
    @State var isMovingToFollower: Bool = false
    @State var readyToConfirm: Bool = false
    @State var movingTo: NewItemPlacement = .backpack
    var movingFrom: NewItemPlacement
    var fromHero: Hero? = nil
    var fromFollower: Follower? = nil
    @ObservedObject var warband: Warband
    @State var heroToGetArmor: Hero? = nil
    @State var followerToGetArmor: Follower? = nil
    
    var body: some View {
        VStack {
            Text("Armor Details")
                .font(.headline)
            
            ScrollView {
                HStack {
                    Text("Name: ")
                        .fontWeight(.bold)
                    Text(armor.name ?? "Unknown Armor")
                    Spacer()
                }
                .padding()
                
                HStack {
                    Text("Armor Rating: ")
                        .fontWeight(.bold)
                    Text("\(armor.rating)")
                    Spacer()
                }
                .padding()
                
                HStack {
                    Text("Rules: ")
                        .fontWeight(.bold)
                    Text(armor.rules ?? "No special rules")
                    Spacer()
                }
                .padding()
                
                HStack {
                    Button {
                        warbandVM.deleteArmor(armor: armor)
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Delete Armor")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(15)
                    }
                    
                    Button {
                        isMovingArmor.toggle()
                    } label: {
                        Text(isMovingArmor ? "Move to..." : "Move Armor")
                            .padding()
                            .foregroundColor(.white)
                            .background(isMovingArmor ? Color.gray : Color.accentColor)
                            .cornerRadius(15)
                    }
                }
             
                if isMovingArmor {
                    HStack {
                        if movingFrom != .stash {
                            Button {
                                isMovingToStash = true
                                isMovingToBackpack = false
                                isMovingToHero = false
                                isMovingToFollower = false
                                readyToConfirm = true
                                movingTo = .stash
                            } label: {
                                Text("Stash")
                                    .padding(8)
                                    .foregroundColor(.white)
                                    .background(isMovingToStash ? Color.accentColor : Color.gray)
                                    .cornerRadius(10)
                            }
                        }
                        
                        if movingFrom != .backpack {
                            Button {
                                isMovingToStash = false
                                isMovingToBackpack = true
                                isMovingToHero = false
                                isMovingToFollower = false
                                readyToConfirm = true
                                movingTo = .backpack
                            } label: {
                                Text("Backpack")
                                    .padding(8)
                                    .foregroundColor(.white)
                                    .background(isMovingToBackpack ? Color.accentColor : Color.gray)
                                    .cornerRadius(10)
                            }
                        }
                        
                        Button {
                            isMovingToStash = false
                            isMovingToBackpack = false
                            isMovingToHero = true
                            isMovingToFollower = false
                            readyToConfirm = false
                            movingTo = .hero
                        } label: {
                            Text("Hero")
                                .padding(8)
                                .foregroundColor(.white)
                                .background(isMovingToHero ? Color.accentColor : Color.gray)
                                .cornerRadius(10)
                        }
                        
                        Button {
                            isMovingToStash = false
                            isMovingToBackpack = false
                            isMovingToHero = false
                            isMovingToFollower = true
                            readyToConfirm = false
                            movingTo = .follower
                        } label: {
                            Text("Follower")
                                .padding(8)
                                .foregroundColor(.white)
                                .background(isMovingToFollower ? Color.accentColor : Color.gray)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.vertical)
                    
                    if isMovingToHero {
                        Picker("Select hero", selection: $heroToGetArmor) {
                            Text("None")
                                .tag(Hero?.none)
                            
                            ForEach(warbandVM.heroes, id: \.self) { hero in
                                Text(hero.name ?? "Unknown hero")
                                    .tag(Hero?.some(hero))
                            }
                        }.onChange(of: heroToGetArmor) { newValue in
                            if heroToGetArmor != nil {
                                readyToConfirm = true
                            }
                        }
                    }
                    
                    if isMovingToFollower {
                        Picker("Select follower", selection: $followerToGetArmor) {
                            ForEach(warbandVM.followers, id: \.self) { follower in
                                Text("None")
                                    .tag(Follower?.none)
                                
                                Text(follower.name ?? "Unknown follower")
                                    .tag(Follower?.some(follower))
                            }
                        }.onChange(of: followerToGetArmor) { newValue in
                            if followerToGetArmor != nil {
                                readyToConfirm = true
                            }
                        }
                    }
                    
                    if readyToConfirm {
                        Button {
                            warbandVM.moveArmor(warband: warband, armor: armor, from: movingFrom, fromHero: fromHero, fromFollower: fromFollower, to: movingTo, toHero: heroToGetArmor, toFollower: followerToGetArmor)
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Move Armor")
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.accentColor)
                                .cornerRadius(15)
                        }
                    }
                }
                
            }
            
        }
    }
}

struct ArmorDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let previewWarband = Warband(context: viewContext)
        previewWarband.name = "The Brightguard"
        let previewHero = Hero(context: viewContext)
        previewHero.name = "Valten"
        previewHero.origin = "Human"
        let previewArmor = Armor(context: viewContext)
        previewArmor.name = "Partial Armor"
        previewArmor.rules = "None"
        
        return ArmorDetailView(warbandVM: WarbandViewModel(), armor: previewArmor, movingFrom: .backpack, warband: previewWarband)
    }
}

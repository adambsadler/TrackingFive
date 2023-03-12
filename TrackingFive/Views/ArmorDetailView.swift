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
            HeaderView(size: .medium, text: "Armor Details", widthPercentage: 0.5, height: 40)
                .padding(.vertical)
            
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
                    CustomButton(text: "Delete Armor", size: .medium, style: .cancel) {
                        warbandVM.deleteArmor(armor: armor)
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                    CustomButton(text: isMovingArmor ? "Move to..." : "Move Armor", size: .medium, style: isMovingArmor ? .inactive : .active) {
                        isMovingArmor.toggle()
                    }
                }
                .padding(.top)
             
                if isMovingArmor {
                    HStack {
                        if movingFrom != .stash {
                            CustomButton(text: "Stash", size: .small, style: isMovingToStash ? .active : .inactive) {
                                isMovingToStash = true
                                isMovingToBackpack = false
                                isMovingToHero = false
                                isMovingToFollower = false
                                readyToConfirm = true
                                movingTo = .stash
                            }
                        }
                        
                        if movingFrom != .backpack {
                            CustomButton(text: "Backpack", size: .small, style: isMovingToBackpack ? .active : .inactive) {
                                isMovingToStash = false
                                isMovingToBackpack = true
                                isMovingToHero = false
                                isMovingToFollower = false
                                readyToConfirm = true
                                movingTo = .backpack
                            }
                        }
                        
                        CustomButton(text: "Hero", size: .small, style: isMovingToHero ? .active : .inactive) {
                            isMovingToStash = false
                            isMovingToBackpack = false
                            isMovingToHero = true
                            isMovingToFollower = false
                            readyToConfirm = false
                            movingTo = .hero
                        }
                        
                        CustomButton(text: "Follower", size: .small, style: isMovingToFollower ? .active : .inactive) {
                            isMovingToStash = false
                            isMovingToBackpack = false
                            isMovingToHero = false
                            isMovingToFollower = true
                            readyToConfirm = false
                            movingTo = .follower
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
                        CustomButton(text: "Move Armor", size: .medium, style: .active) {
                            warbandVM.moveArmor(warband: warband, armor: armor, from: movingFrom, fromHero: fromHero, fromFollower: fromFollower, to: movingTo, toHero: heroToGetArmor, toFollower: followerToGetArmor)
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                
            }
            .padding(.horizontal)
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

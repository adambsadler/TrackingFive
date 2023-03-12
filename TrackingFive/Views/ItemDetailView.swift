//
//  ItemDetailView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 2/24/23.
//

import SwiftUI

struct ItemDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var warbandVM: WarbandViewModel
    @ObservedObject var item: EquipmentItem
    @State var isMovingItem: Bool = false
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
    @State var heroToGetItem: Hero? = nil
    @State var followerToGetItem: Follower? = nil
    
    var body: some View {
        VStack {
            HeaderView(size: .medium, text: "Item Details", widthPercentage: 0.5, height: 40)
                .padding(.vertical)
            
            ScrollView {
                HStack {
                    Text("Name: ")
                        .fontWeight(.bold)
                    Text(item.name ?? "Unknown Item")
                    Spacer()
                }
                .padding()
                
                HStack {
                    Text("Rules: ")
                        .fontWeight(.bold)
                    Text(item.rules ?? "No special rules")
                    Spacer()
                }
                .padding()
                
                HStack {
                    CustomButton(text: "Delete Item", size: .medium, style: .cancel) {
                        warbandVM.deleteItem(item: item)
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                    CustomButton(text: isMovingItem ? "Move to..." : "Move Item", size: .medium, style: isMovingItem ? .inactive : .active) {
                        isMovingItem.toggle()
                    }
                }
                .padding(.top)
             
                if isMovingItem {
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
                        Picker("Select hero", selection: $heroToGetItem) {
                            Text("None")
                                .tag(Hero?.none)
                            
                            ForEach(warbandVM.heroes, id: \.self) { hero in
                                Text(hero.name ?? "Unknown hero")
                                    .tag(Hero?.some(hero))
                            }
                        }.onChange(of: heroToGetItem) { newValue in
                            if heroToGetItem != nil {
                                readyToConfirm = true
                            }
                        }
                    }
                    
                    if isMovingToFollower {
                        Picker("Select follower", selection: $followerToGetItem) {
                            ForEach(warbandVM.followers, id: \.self) { follower in
                                Text("None")
                                    .tag(Follower?.none)
                                
                                Text(follower.name ?? "Unknown follower")
                                    .tag(Follower?.some(follower))
                            }
                        }.onChange(of: followerToGetItem) { newValue in
                            if followerToGetItem != nil {
                                readyToConfirm = true
                            }
                        }
                    }
                    
                    if readyToConfirm {
                        CustomButton(text: "Move Item", size: .medium, style: .active) {
                            warbandVM.moveItem(warband: warband, item: item, from: movingFrom, fromHero: fromHero, fromFollower: fromFollower, to: movingTo, toHero: heroToGetItem, toFollower: followerToGetItem)
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let previewWarband = Warband(context: viewContext)
        previewWarband.name = "The Brightguard"
        let previewHero = Hero(context: viewContext)
        previewHero.name = "Valten"
        previewHero.origin = "Human"
        let previewItem = EquipmentItem(context: viewContext)
        previewItem.name = "Silvertree Leaf"
        previewItem.rules = "Reroll post-game injuries"
        
        return ItemDetailView(warbandVM: WarbandViewModel(), item: previewItem, movingFrom: .backpack, warband: previewWarband)
    }
}

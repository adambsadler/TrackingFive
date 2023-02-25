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
    var warband: Warband? = nil
    @State var heroToGetItem: Hero? = nil
    @State var followerToGetItem: Follower? = nil
    
    var body: some View {
        VStack {
            Text("Item Details")
                .font(.headline)
            
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
                    Button {
                        warbandVM.deleteItem(item: item)
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Delete Item")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(15)
                    }
                    
                    Button {
                        isMovingItem.toggle()
                    } label: {
                        Text(isMovingItem ? "Move to..." : "Move Item")
                            .padding()
                            .foregroundColor(.white)
                            .background(isMovingItem ? Color.gray : Color.accentColor)
                            .cornerRadius(15)
                    }
                }
             
                if isMovingItem {
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
                        Button {
                            warbandVM.moveItem(item: item, from: movingFrom, to: movingTo, warband: warband, hero: heroToGetItem, follower: followerToGetItem)
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Move Item")
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
        
        return ItemDetailView(warbandVM: WarbandViewModel(), item: previewItem, movingFrom: .backpack)
    }
}

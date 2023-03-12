//
//  WeaponDetailView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 2/25/23.
//

import SwiftUI

struct WeaponDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var warbandVM: WarbandViewModel
    @ObservedObject var weapon: Weapon
    @State var isMovingWeapon: Bool = false
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
    @State var heroToGetWeapon: Hero? = nil
    @State var followerToGetWeapon: Follower? = nil
    
    var body: some View {
        VStack {
            HeaderView(size: .medium, text: "Weapon Details", widthPercentage: 0.5, height: 40)
                .padding(.vertical)
            
            ScrollView {
                Group {
                    HStack {
                        Text("Name: ")
                            .fontWeight(.bold)
                        Text(weapon.name ?? "Unknown Weapon")
                        Spacer()
                    }
                    .padding()
                    
                    HStack {
                        Text("Type: ")
                            .fontWeight(.bold)
                        Text(weapon.type ?? "Unknown Type")
                        Spacer()
                    }
                    .padding()
                    
                    if weapon.type == WeaponType.ranged.rawValue {
                        HStack {
                            Text("Range: ")
                                .fontWeight(.bold)
                            Text("\(weapon.range)")
                            Spacer()
                        }
                        .padding()
                    }
                    
                    HStack {
                        Text("Overcome Armor: ")
                            .fontWeight(.bold)
                        Text("\(weapon.overcomeArmor)")
                        Spacer()
                    }
                    .padding()
                    
                    HStack {
                        Text("Overcome Toughness: ")
                            .fontWeight(.bold)
                        Text("\(weapon.overcomeToughness)")
                        Spacer()
                    }
                    .padding()
                    
                    HStack {
                        Text("Rules: ")
                            .fontWeight(.bold)
                        Text(weapon.rules ?? "No special rules")
                        Spacer()
                    }
                    .padding()
                }
                
                HStack {
                    Button {
                        warbandVM.deleteWeapon(weapon: weapon)
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Delete Weapon")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(15)
                    }
                    
                    Button {
                        isMovingWeapon.toggle()
                    } label: {
                        Text(isMovingWeapon ? "Move to..." : "Move Weapon")
                            .padding()
                            .foregroundColor(.white)
                            .background(isMovingWeapon ? Color.gray : Color.accentColor)
                            .cornerRadius(15)
                    }
                }
                .padding(.top)
             
                if isMovingWeapon {
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
                        Picker("Select hero", selection: $heroToGetWeapon) {
                            Text("None")
                                .tag(Hero?.none)
                            
                            ForEach(warbandVM.heroes, id: \.self) { hero in
                                Text(hero.name ?? "Unknown hero")
                                    .tag(Hero?.some(hero))
                            }
                        }.onChange(of: heroToGetWeapon) { newValue in
                            if heroToGetWeapon != nil {
                                readyToConfirm = true
                            }
                        }
                    }
                    
                    if isMovingToFollower {
                        Picker("Select follower", selection: $followerToGetWeapon) {
                            ForEach(warbandVM.followers, id: \.self) { follower in
                                Text("None")
                                    .tag(Follower?.none)
                                
                                Text(follower.name ?? "Unknown follower")
                                    .tag(Follower?.some(follower))
                            }
                        }.onChange(of: followerToGetWeapon) { newValue in
                            if followerToGetWeapon != nil {
                                readyToConfirm = true
                            }
                        }
                    }
                    
                    if readyToConfirm {
                        Button {
                            warbandVM.moveWeapon(warband: warband, weapon: weapon, from: movingFrom, fromHero: fromHero, fromFollower: fromFollower, to: movingTo, toHero: heroToGetWeapon, toFollower: followerToGetWeapon)
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Move Weapon")
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.accentColor)
                                .cornerRadius(15)
                        }
                    }
                }
                
            }
            .padding(.horizontal)
        }
    }
}

struct WeaponDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let previewWarband = Warband(context: viewContext)
        previewWarband.name = "The Brightguard"
        let previewHero = Hero(context: viewContext)
        previewHero.name = "Valten"
        previewHero.origin = "Human"
        let previewWeapon = Weapon(context: viewContext)
        previewWeapon.name = "Bastard Sword"
        previewWeapon.rules = "None"
        
        return WeaponDetailView(warbandVM: WarbandViewModel(), weapon: previewWeapon, movingFrom: .backpack, warband: previewWarband)
    }
}

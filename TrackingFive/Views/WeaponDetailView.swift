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
    @State var isEditingWeapon: Bool = false
    @State var overcomeArmor: Int = 0
    @State var overcomeTough: Int = 0
    @State var range: Int = 0
    @State var weaponRules: String = ""
    var movingFrom: NewItemPlacement
    var fromHero: Hero? = nil
    var fromFollower: Follower? = nil
    @ObservedObject var warband: Warband
    @State var heroToGetWeapon: Hero? = nil
    @State var followerToGetWeapon: Follower? = nil
    
    func setValues() {
        overcomeTough = Int(weapon.overcomeToughness)
        overcomeArmor = Int(weapon.overcomeArmor)
        weaponRules = weapon.rules ?? ""
        if weapon.type == WeaponType.ranged.rawValue {
            range = Int(weapon.range)
        }
    }
    
    var body: some View {
        VStack {
            ZStack {
                HeaderView(size: .medium, text: "Weapon Details", widthPercentage: 0.5, height: 40)
                    .padding(.vertical)
                
                HStack {
                    Spacer()
                    if isEditingWeapon {
                        Button {
                            setValues()
                            isEditingWeapon.toggle()
                        } label: {
                            Image(systemName: "x.circle.fill")
                                .foregroundColor(.red)
                                .padding(.trailing, 10)
                        }
                    }
                    Button {
                        if isEditingWeapon {
                            warbandVM.updateWeapon(weapon: weapon, range: range, overcomeArmor: overcomeArmor, overcomeToughness: overcomeTough, rules: weaponRules)
                        }
                        
                        isEditingWeapon.toggle()
                    } label: {
                        Image(systemName: isEditingWeapon ? "checkmark.circle.fill" : "square.and.pencil")
                            .padding(.trailing)
                            .foregroundColor(Color("LightGreen"))
                    }
                }
            }
            
            
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
                        if isEditingWeapon {
                            HStack {
                                Text("Range: ")
                                    .fontWeight(.bold)
                                TextField("Weapon Range", value: $range, formatter: NumberFormatter())
                                    .keyboardType(.numberPad)
                            }
                            .padding()
                        } else {
                            HStack {
                                Text("Range: ")
                                    .fontWeight(.bold)
                                Text("\(weapon.range)")
                                Spacer()
                            }
                            .padding()
                        }
                    }
                    
                    if isEditingWeapon {
                        HStack {
                            Text("Overcome Armor: ")
                                .fontWeight(.bold)
                            Picker("Score", selection: $overcomeArmor) {
                                ForEach(-1 ..< 4, id: \.self) {
                                    Text("\($0)")
                                }
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Text("Overcome Toughness: ")
                                .fontWeight(.bold)
                            Picker("Score", selection: $overcomeTough) {
                                ForEach(-1 ..< 4, id: \.self) {
                                    Text("\($0)")
                                }
                            }
                            Spacer()
                        }
                        .padding()

                        HStack {
                            Text("Rules: ")
                                .fontWeight(.bold)
                            TextField("Weapon Rules", text: $weaponRules)
                                .disableAutocorrection(true)
                        }
                        .padding()
                    } else {
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
                }
                
                if !isEditingWeapon {
                    HStack {
                        CustomButton(text: "Delete Weapon", size: .medium, style: .cancel) {
                            warbandVM.deleteWeapon(weapon: weapon)
                            presentationMode.wrappedValue.dismiss()
                        }
                        
                        CustomButton(text: isMovingWeapon ? "Move to..." : "Move Weapon", size: .medium, style: isMovingWeapon ? .inactive : .active) {
                            isMovingWeapon.toggle()
                        }
                    }
                    .padding(.top)
                }
             
                if isMovingWeapon {
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
                        CustomButton(text: "Move Weapon", size: .medium, style: .active) {
                            warbandVM.moveWeapon(warband: warband, weapon: weapon, from: movingFrom, fromHero: fromHero, fromFollower: fromFollower, to: movingTo, toHero: heroToGetWeapon, toFollower: followerToGetWeapon)
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                
            }
            .padding(.horizontal)
        }
        .onAppear {
            setValues()
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

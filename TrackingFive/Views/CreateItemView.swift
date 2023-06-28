//
//  CreateItemView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/25/22.
//

import SwiftUI

struct CreateItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var warbandVM: WarbandViewModel
    var warband: Warband? = nil
    @State var isCreatingItem: Bool = false
    @State var isCreatingWeapon: Bool = false
    @State var isCreatingArmor: Bool = false
    @State var newItemName: String = ""
    @State var newItemRules: String = ""
    @State var weaponType: WeaponType = .melee
    @State var overcomeArmor: Int = 0
    @State var overcomeTough: Int = 0
    @State var range: Int = 0
    @State var armorRatihg: Int = 0
    var placement: NewItemPlacement
    var hero: Hero? = nil
    var follower: Follower? = nil
    
    private func resetValues() {
        newItemName = ""
        newItemRules = ""
        weaponType = .melee
        overcomeArmor = 0
        overcomeTough = 0
        range = 0
        armorRatihg = 0
    }
    
    var body: some View {
        VStack {
            HeaderView(size: .medium, text: "Add Equipment", widthPercentage: 0.5, height: 40)
                .padding(.top)
            
            HStack {
                CustomButton(text: "Item", size: .medium, style: isCreatingItem ? .active : .inactive) {
                    isCreatingItem = true
                    isCreatingWeapon = false
                    isCreatingArmor = false
                }
                
                CustomButton(text: "Weapon", size: .medium, style: isCreatingWeapon ? .active : .inactive) {
                    isCreatingItem = false
                    isCreatingWeapon = true
                    isCreatingArmor = false
                }
                
                CustomButton(text: "Armor", size: .medium, style: isCreatingArmor ? .active : .inactive) {
                    isCreatingItem = false
                    isCreatingWeapon = false
                    isCreatingArmor = true
                }
            }
            .padding()
            
            VStack {
                if isCreatingItem {
                    HStack {
                        Text("Name: ")
                            .fontWeight(.bold)
                        TextField("Item Name", text: $newItemName)
                            .disableAutocorrection(true)
                    }
                    .padding()
                    
                    HStack {
                        Text("Rules: ")
                            .fontWeight(.bold)
                        TextField("Item Rules", text: $newItemRules)
                            .disableAutocorrection(true)
                    }
                    .padding()
                }
                
                if isCreatingWeapon {
                    HStack {
                        Text("Weapon Type: ")
                            .fontWeight(.bold)
                        Picker("Select type of weapon", selection: $weaponType) {
                            ForEach(WeaponType.allCases, id: \.self) { value in
                                Text(value.localizedName)
                                    .tag(value)
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Name: ")
                            .fontWeight(.bold)
                        TextField("Weapon Name", text: $newItemName)
                            .disableAutocorrection(true)
                    }
                    .padding(.horizontal)
                    
                    if weaponType == .ranged {
                        HStack {
                            Text("Range: ")
                                .fontWeight(.bold)
                            TextField("Weapon Range", value: $range, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                        }
                        .padding(.horizontal)
                    }
                    
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
                    .padding(.horizontal)

                    HStack {
                        Text("Rules: ")
                            .fontWeight(.bold)
                        TextField("Weapon Rules", text: $newItemRules)
                            .disableAutocorrection(true)
                    }
                    .padding(.horizontal)
                }
                
                if isCreatingArmor {
                    HStack {
                        Text("Name: ")
                            .fontWeight(.bold)
                        TextField("Armor Name", text: $newItemName)
                            .disableAutocorrection(true)
                    }
                    .padding()
                    
                    HStack {
                        Text("Armor Rating: ")
                            .fontWeight(.bold)
                        Picker("Score", selection: $armorRatihg) {
                            ForEach(0 ..< 4, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Rules: ")
                            .fontWeight(.bold)
                        TextField("Armor Rules", text: $newItemRules)
                            .disableAutocorrection(true)
                    }
                    .padding()
                }
            }
            .padding(.horizontal)
            
            HStack {
                CustomButton(text: "Cancel", size: .medium, style: .cancel) {
                    presentationMode.wrappedValue.dismiss()
                }
                
                if isCreatingItem {
                    CustomButton(text: "Create", size: .medium, style: .active) {
                        warbandVM.createItem(name: newItemName, rules: newItemRules, placement: placement, warband: warband, hero: hero, follower: follower)
                        resetValues()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                if isCreatingWeapon {
                    CustomButton(text: "Create", size: .medium, style: .active) {
                        warbandVM.createWeapon(name: newItemName, type: weaponType, range: range, overcomeArmor: overcomeArmor, overcomeToughness: overcomeTough, rules: newItemRules, placement: placement, warband: warband, hero: hero, follower: follower)
                        resetValues()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                if isCreatingArmor {
                    CustomButton(text: "Create", size: .medium, style: .active) {
                        warbandVM.createArmor(name: newItemName, rating: armorRatihg, rules: newItemRules, placement: placement, warband: warband, hero: hero, follower: follower)
                        resetValues()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .padding()
            
            Spacer()
        }
    }
}

struct CreateItemView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let previewWarband = Warband(context: viewContext)
        previewWarband.name = "The Brightguard"
        
        return CreateItemView(warbandVM: WarbandViewModel(), warband: previewWarband, placement: .stash)
    }
}

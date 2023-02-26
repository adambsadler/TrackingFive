//
//  EquipmentStashView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/25/22.
//

import SwiftUI

struct EquipmentStashView: View {
    @ObservedObject var warbandVM: WarbandViewModel
    @ObservedObject var warband: Warband
    
    var body: some View {
        VStack {
            HStack {
                Text("Equipment Stash")
                    .font(.headline)
                    .fontWeight(.heavy)
                    .padding(.top)
                Spacer()
                NavigationLink {
                    CreateItemView(warbandVM: warbandVM, warband: warband, placement: .stash)
                } label: {
                    Image(systemName: "plus.circle")
                        .foregroundColor(.accentColor)
                }
            }
            
            Divider()
            
            if !warbandVM.stashedItems.isEmpty {
                HStack {
                    Text("Items")
                        .fontWeight(.bold)
                    Spacer()
                }
            }
            
            ForEach(warbandVM.stashedItems, id: \.self) { item in
                if let itemName = item.name {
                    HStack {
                        Text("• \(itemName)")
                        Spacer()
                        NavigationLink {
                            ItemDetailView(warbandVM: warbandVM, item: item, movingFrom: .stash, warband: warband)
                        } label: {
                            Image(systemName: "questionmark.circle.fill")
                                .foregroundColor(.accentColor)
                                .padding(.trailing)
                        }
                    }
                    .padding(.bottom, 5)
                }
            }
            
            if !warbandVM.stashedWeapons.isEmpty {
                HStack {
                    Text("Weapons")
                        .fontWeight(.bold)
                    Spacer()
                }
            }
            
            ForEach(warbandVM.stashedWeapons, id: \.self) { weapon in
                if let weaponName = weapon.name {
                    HStack {
                        Text("• \(weaponName)")
                        Spacer()
                        NavigationLink {
                            WeaponDetailView(warbandVM: warbandVM, weapon: weapon, movingFrom: .stash, warband: warband)
                        } label: {
                            Image(systemName: "questionmark.circle.fill")
                                .foregroundColor(.accentColor)
                                .padding(.trailing)
                        }
                    }
                    .padding(.bottom, 5)
                }
            }
            
            if !warbandVM.stashedArmor.isEmpty {
                HStack {
                    Text("Armor")
                        .fontWeight(.bold)
                    Spacer()
                }
            }
            
            ForEach(warbandVM.stashedArmor, id: \.self) { armor in
                if let armorName = armor.name {
                    HStack {
                        Text("• \(armorName)")
                        Spacer()
                        NavigationLink {
                            ArmorDetailView(warbandVM: warbandVM, armor: armor, movingFrom: .stash, warband: warband)
                        } label: {
                            Image(systemName: "questionmark.circle.fill")
                                .foregroundColor(.accentColor)
                                .padding(.trailing)
                        }
                    }
                    .padding(.bottom, 5)
                }
            }
        }
        .padding(.horizontal)
    }
}

struct EquipmentStashView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let previewWarband = Warband(context: viewContext)
        previewWarband.name = "The Brightguard"
        
        return EquipmentStashView(warbandVM: WarbandViewModel(), warband: previewWarband)
    }
}

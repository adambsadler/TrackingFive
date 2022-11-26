//
//  BackpackView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/26/22.
//

import SwiftUI

struct BackpackView: View {
    @ObservedObject var warbandVM: WarbandViewModel
    @ObservedObject var warband: Warband
    
    var body: some View {
        VStack {
            if !warbandVM.itemsInBackpack.isEmpty {
                HStack {
                    Text("Items")
                        .fontWeight(.bold)
                    Spacer()
                }
            }
            
            ForEach(warbandVM.itemsInBackpack, id: \.self) { item in
                if let itemName = item.name {
                    HStack {
                        Text("• \(itemName)")
                        Spacer()
                        NavigationLink {
                            // item detail view
                        } label: {
                            Image(systemName: "questionmark.circle.fill")
                                .foregroundColor(.accentColor)
                                .padding(.trailing)
                        }
                    }
                    .padding(.bottom, 5)
                }
            }
            
            if !warbandVM.weaponsInBackpack.isEmpty {
                HStack {
                    Text("Weapons")
                        .fontWeight(.bold)
                    Spacer()
                }
            }
            
            ForEach(warbandVM.weaponsInBackpack, id: \.self) { weapon in
                if let weaponName = weapon.name {
                    HStack {
                        Text("• \(weaponName)")
                        Spacer()
                        NavigationLink {
                            // weapon detail view
                        } label: {
                            Image(systemName: "questionmark.circle.fill")
                                .foregroundColor(.accentColor)
                                .padding(.trailing)
                        }
                    }
                    .padding(.bottom, 5)
                }
            }
            
            if !warbandVM.armorInBackpack.isEmpty {
                HStack {
                    Text("Armor")
                        .fontWeight(.bold)
                    Spacer()
                }
            }
            
            ForEach(warbandVM.armorInBackpack, id: \.self) { armor in
                if let armorName = armor.name {
                    HStack {
                        Text("• \(armorName)")
                        Spacer()
                        NavigationLink {
                            // armor detail view
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
    }
}

struct BackpackView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let previewWarband = Warband(context: viewContext)
        previewWarband.name = "The Brightguard"
        
        return BackpackView(warbandVM: WarbandViewModel(), warband: previewWarband)
    }
}

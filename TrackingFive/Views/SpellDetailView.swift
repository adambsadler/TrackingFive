//
//  SpellDetailView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 2/25/23.
//

import SwiftUI

struct SpellDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var warbandVM: WarbandViewModel
    @ObservedObject var spell: Spell
    
    var body: some View {
        VStack {
            HeaderView(size: .medium, text: "Spell Details", widthPercentage: 0.5, height: 40)
                .padding(.vertical)
            
            VStack {
                HStack {
                    Text("Name: ")
                        .fontWeight(.bold)
                    Text(spell.name ?? "Unknown Spell")
                    Spacer()
                }
                .padding()
                
                HStack {
                    Text("Incantation: ")
                        .fontWeight(.bold)
                    Text("\(spell.incantation)+")
                    Spacer()
                }
                .padding()
                
                HStack {
                    Text("Rules: ")
                        .fontWeight(.bold)
                    Text(spell.rules ?? "No special rules")
                    Spacer()
                }
                .padding()
            }
            .padding(.horizontal)
            
            Button {
                warbandVM.deleteSpell(spell: spell)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Delete Spell")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(15)
            }
            .padding()
            
            Spacer()
        }
    }
}

struct SpellDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let previewWarband = Warband(context: viewContext)
        previewWarband.name = "The Brightguard"
        let previewSpell = Spell(context: viewContext)
        previewSpell.name = "Fireball"
        previewSpell.rules = "Deal some damage, burn stuff"
        
        return SpellDetailView(warbandVM: WarbandViewModel(), spell: previewSpell)
    }
}

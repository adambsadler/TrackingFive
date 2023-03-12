//
//  CreateSpellView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 2/24/23.
//

import SwiftUI

struct CreateSpellView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var warbandVM: WarbandViewModel
    @ObservedObject var hero: Hero
    @State var newSpellName: String = ""
    @State var spellIncantation: Int = 0
    @State var newSpellRules: String = ""
    
    var body: some View {
        VStack {
            HeaderView(size: .medium, text: "Create a New Spell", widthPercentage: 0.5, height: 40)
                .padding(.vertical)
            
            VStack {
                HStack {
                    Text("Name: ")
                        .fontWeight(.bold)
                    TextField("Spell Name", text: $newSpellName)
                        .disableAutocorrection(true)
                }
                .padding()
                
                HStack {
                    Text("Incantation: ")
                        .fontWeight(.bold)
                    Picker("Incantation", selection: $spellIncantation) {
                        ForEach(5 ..< 9) {
                            Text("\($0) +")
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Rules: ")
                        .fontWeight(.bold)
                    TextField("Spell Rules", text: $newSpellRules)
                        .disableAutocorrection(true)
                }
                .padding()
            }
            .padding(.horizontal)
            
            Button {
                warbandVM.addSpellToHero(hero: hero, incantation: spellIncantation, name: newSpellName, rules: newSpellRules)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Add Spell to Hero")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.accentColor)
                    .cornerRadius(15)
            }
            .padding(.vertical)
            
            Spacer()
        }
    }
}

struct CreateSpellView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let previewWarband = Warband(context: viewContext)
        previewWarband.name = "The Brightguard"
        let previewHero = Hero(context: viewContext)
        previewHero.name = "Valten"
        previewHero.origin = "Human"
        
        return CreateSpellView(warbandVM: WarbandViewModel(), hero: previewHero)
    }
}

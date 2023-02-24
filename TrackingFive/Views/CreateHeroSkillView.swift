//
//  CreateHeroSkillView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 2/24/23.
//

import SwiftUI

struct CreateHeroSkillView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var warbandVM: WarbandViewModel
    @ObservedObject var hero: Hero
    @State var newSkillName: String = ""
    @State var newSkillRules: String = ""
    
    var body: some View {
        VStack {
            Text("Create a New Skill")
                .font(.headline)
            
            HStack {
                Text("Name: ")
                    .fontWeight(.bold)
                TextField("Item Name", text: $newSkillName)
                    .disableAutocorrection(true)
            }
            .padding()
            
            HStack {
                Text("Rules: ")
                    .fontWeight(.bold)
                TextField("Item Rules", text: $newSkillRules)
                    .disableAutocorrection(true)
            }
            .padding()
            
            Button {
                warbandVM.addSkillToHero(hero: hero, name: newSkillName, rules: newSkillRules)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Add Skill to Hero")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.accentColor)
                    .cornerRadius(15)
            }
            
            Spacer()
        }
        .padding()
    }
}

struct CreateHeroSkillView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let previewWarband = Warband(context: viewContext)
        previewWarband.name = "The Brightguard"
        let previewHero = Hero(context: viewContext)
        previewHero.name = "Valten"
        previewHero.origin = "Human"
        
        return CreateHeroSkillView(warbandVM: WarbandViewModel(), hero: previewHero)
    }
}

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
            HeaderView(size: .medium, text: "Create a New Skill", widthPercentage: 0.5, height: 40)
                .padding(.vertical)
            
            VStack {
                HStack {
                    Text("Name: ")
                        .fontWeight(.bold)
                    TextField("Skill Name", text: $newSkillName)
                        .disableAutocorrection(true)
                }
                .padding()
                
                HStack {
                    Text("Rules: ")
                        .fontWeight(.bold)
                    TextField("Skill Rules", text: $newSkillRules)
                        .disableAutocorrection(true)
                }
                .padding()
            }
            .padding(.horizontal)
            
            CustomButton(text: "Add Skill to Hero", size: .medium, style: .active) {
                warbandVM.addSkillToHero(hero: hero, name: newSkillName, rules: newSkillRules)
                presentationMode.wrappedValue.dismiss()
            }
            .padding(.vertical)
            
            Spacer()
        }
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

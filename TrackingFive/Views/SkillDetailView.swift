//
//  SkillDetailView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 2/25/23.
//

import SwiftUI

struct SkillDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var warbandVM: WarbandViewModel
    @ObservedObject var skill: Skill
    
    var body: some View {
        VStack {
            Text("Skill Details")
                .font(.headline)
            
            HStack {
                Text("Name: ")
                    .fontWeight(.bold)
                Text(skill.name ?? "Unknown Skill")
                Spacer()
            }
            .padding()
            
            HStack {
                Text("Rules: ")
                    .fontWeight(.bold)
                Text(skill.rules ?? "No special rules")
                Spacer()
            }
            .padding()
            
            Button {
                warbandVM.deleteSkill(skill: skill)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Delete Skill")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(15)
            }
            
            Spacer()
        }
        .padding()
    }
}

struct SkillDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let previewWarband = Warband(context: viewContext)
        previewWarband.name = "The Brightguard"
        let previewSkill = Skill(context: viewContext)
        previewSkill.name = "+1 speech"
        previewSkill.rules = "Add 1 to speech tests"
        
        return SkillDetailView(warbandVM: WarbandViewModel(), skill: previewSkill)
    }
}

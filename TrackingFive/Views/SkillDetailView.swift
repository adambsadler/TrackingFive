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
            HeaderView(size: .medium, text: "Skill Details", widthPercentage: 0.5, height: 40)
                .padding(.vertical)
            
            VStack {
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
                
                CustomButton(text: "Delete Skill", size: .medium, style: .cancel) {
                    warbandVM.deleteSkill(skill: skill)
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
            }
            .padding(.horizontal)
            
            Spacer()
        }
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

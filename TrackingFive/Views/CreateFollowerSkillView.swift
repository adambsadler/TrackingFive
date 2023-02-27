//
//  CreateFollowerSkillView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 2/26/23.
//

import SwiftUI

struct CreateFollowerSkillView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var warbandVM: WarbandViewModel
    @ObservedObject var follower: Follower
    @State var newSkillName: String = ""
    @State var newSkillRules: String = ""
    
    var body: some View {
        VStack {
            Text("Create a New Skill")
                .font(.headline)
            
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
            
            Button {
                warbandVM.addSkillToFollower(follower: follower, name: newSkillName, rules: newSkillRules)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Add Skill to Follower")
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

struct CreateFollowerSkillView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let previewWarband = Warband(context: viewContext)
        previewWarband.name = "The Brightguard"
        let previewFollower = Follower(context: viewContext)
        previewFollower.name = "Guyver"
        
        return CreateFollowerSkillView(warbandVM: WarbandViewModel(), follower: previewFollower)
    }
}

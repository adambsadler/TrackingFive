//
//  EditWarbandDetailsView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/19/22.
//

import SwiftUI

struct EditWarbandDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var warbandVM: WarbandViewModel
    @ObservedObject var warband: Warband
    @State var warbandName: String = ""
    @State var region: String = ""
    @State var currentLocation: String = ""
    @State var storyPoints: Int64 = 0
    @State var adventurePoints: Int64 = 0
    @State var goldMarks: Int64 = 0
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Warband Name")) {
                    TextField("Name of Warband", text: $warbandName)
                        .disableAutocorrection(true)
                }
                Section(header: Text("Region")) {
                    TextField("Name of Region", text: $region)
                        .disableAutocorrection(true)
                }
                Section(header: Text("Current Location")) {
                    TextField("Name of Location", text: $currentLocation)
                        .disableAutocorrection(true)
                }
                Section(header: Text("Resources")) {
                    HStack {
                        Text("Story Points: ")
                        TextField("Story Points", value: $storyPoints, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                    }
                    HStack {
                        Text("Adventure Points: ")
                        TextField("Adventure Points", value: $adventurePoints, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                    }
                    HStack {
                        Text("Gold Marks: ")
                        TextField("Gold Marks", value: $goldMarks, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                    }
                }
                Section(footer: CustomButton(text: "Update Warband", size: .medium, style: .active, action: {
                    warband.name = warbandName
                    warband.region = region
                    warband.currentLocation = currentLocation
                    warband.storyPoints = storyPoints
                    warband.adventurePoints = adventurePoints
                    warband.goldMarks = goldMarks
                    warbandVM.saveData()
                    presentationMode.wrappedValue.dismiss()
                }).frame(maxWidth: .infinity)
                    ){
                    EmptyView()
                }
            }
        }
        .navigationTitle("Edit Warband Details")
        .onAppear {
            DispatchQueue.main.async {
                warbandName = warband.name ?? ""
                region = warband.region ?? ""
                currentLocation = warband.currentLocation ?? ""
                storyPoints = warband.storyPoints
                adventurePoints = warband.adventurePoints
                goldMarks = warband.goldMarks
            }
        }
    }
}

struct EditWarbandDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let previewWarband = Warband(context: viewContext)
        previewWarband.name = "The Brightguard"
        
        return EditWarbandDetailsView(warbandVM: WarbandViewModel(), warband: previewWarband)
    }
}

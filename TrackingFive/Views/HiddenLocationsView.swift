//
//  HiddenLocationsView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/23/22.
//

import SwiftUI

struct HiddenLocationsView: View {
    @ObservedObject var warbandVM: WarbandViewModel
    @ObservedObject var warband: Warband
    @State var isAddingLocation: Bool = false
    @State var newLocationName: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Hidden Locations")
                    .font(.headline)
                    .fontWeight(.heavy)
                    .padding(.top)
                Spacer()
                Button {
                    isAddingLocation.toggle()
                } label: {
                    Image(systemName: "plus.circle")
                        .foregroundColor(.accentColor)
                }
            }
            
            Divider()
            
            ForEach(warbandVM.hiddenLocations, id: \.self) { location in
                if let locationName = location.name {
                    HStack {
                        Text("• \(locationName)")
                        Spacer()
                        Button {
                            warbandVM.deleteHiddenLocation(location: location)
                        } label: {
                            Image(systemName: "x.circle.fill")
                                .foregroundColor(.red)
                                .padding(.trailing)
                        }
                    }
                    .padding(.bottom, 5)
                }
            }
        }
        .padding(.horizontal)
        .alert("Add Hidden Location", isPresented: $isAddingLocation) {
            TextField("Location Name", text: $newLocationName)
                .disableAutocorrection(true)
            Button("Add") {
                warbandVM.createHiddenLocation(name: newLocationName, warband: warband)
                newLocationName = ""
            }
            Button("Cancel", role: .cancel) {
                isAddingLocation.toggle()
                newLocationName = ""
            }
        } message: {
            Text("Enter the name of the hidden location.")
        }
    }
}

struct HiddenLocationsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let previewWarband = Warband(context: viewContext)
        previewWarband.name = "The Brightguard"
        
        return HiddenLocationsView(warbandVM: WarbandViewModel(), warband: previewWarband, isAddingLocation: false)
    }
}

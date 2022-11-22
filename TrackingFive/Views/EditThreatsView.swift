//
//  EditThreatsView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/21/22.
//

import SwiftUI

struct EditThreatsView: View {
    @ObservedObject var warbandVM: WarbandViewModel
    @ObservedObject var warband: Warband
    
    var body: some View {
        VStack {
            if let threat = warband.firstThreat {
                HStack {
                    Text(threat.name ?? "First Threat")
                        .fontWeight(.bold)
                    Spacer()
                    Button {
                        warbandVM.deleteThreat(threat: threat)
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 25)
                            .foregroundColor(.red)
                            .padding(.trailing)
                    }
                }
                .padding(.vertical)
            }
            
            if let threat = warband.secondThreat {
                HStack {
                    Text(threat.name ?? "Second Threat")
                        .fontWeight(.bold)
                    Spacer()
                    Button {
                        warbandVM.deleteThreat(threat: threat)
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 25)
                            .foregroundColor(.red)
                            .padding(.trailing)
                    }
                }
                .padding(.vertical)
            }
            
            if let threat = warband.thirdThreat {
                HStack {
                    Text(threat.name ?? "Third Threat")
                        .fontWeight(.bold)
                    Spacer()
                    Button {
                        warbandVM.deleteThreat(threat: threat)
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 25)
                            .foregroundColor(.red)
                            .padding(.trailing)
                    }
                }
                .padding(.vertical)
            }
        }
    }
}

struct EditThreatsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let previewWarband = Warband(context: viewContext)
        previewWarband.name = "The Brightguard"
        let newThreat = Threat(context: viewContext)
        newThreat.name = "The Ruin Within"
        newThreat.level = 5
        previewWarband.firstThreat = newThreat
        
        return EditThreatsView(warbandVM: WarbandViewModel(), warband: previewWarband)
    }
}

//
//  WarbandDetailView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/14/22.
//

import SwiftUI

struct WarbandDetailView: View {
    @ObservedObject var warbandVM: WarbandViewModel
    @ObservedObject var warband: Warband
    @State var isShowingNote: Bool = false
    @State var isAddingNote: Bool = false
    @State var isEditingThreats: Bool = false

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Group {
                    HStack {
                        Text("Warband Details")
                            .font(.headline)
                            .fontWeight(.heavy)
                            .padding(.leading)
                            .padding(.top)
                        Spacer()
                        NavigationLink {
                            EditWarbandDetailsView(warbandVM: warbandVM, warband: warband)
                        } label: {
                            Image(systemName: "square.and.pencil")
                                .padding(.trailing)
                                .foregroundColor(.accentColor)
                        }
                    }
                    
                    Divider()
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text("Region:")
                                .fontWeight(.bold)
                            Text(warband.region ?? "None")
                            Spacer()
                        }
                        HStack {
                            Text("Current Location:")
                                .fontWeight(.bold)
                            Text(warband.currentLocation ?? "None")
                        }
                        HStack {
                            Text("Story Points:")
                                .fontWeight(.bold)
                            Text("\(warband.storyPoints)")
                        }
                        HStack {
                            Text("Adventure Points:")
                                .fontWeight(.bold)
                            Text("\(warband.adventurePoints)")
                        }
                        HStack {
                            Text("Gold Marks:")
                                .fontWeight(.bold)
                            Text("\(warband.goldMarks)")
                        }
                    }
                    .padding(.horizontal)
                    
                    NotesView(warbandVM: warbandVM, warband: warband)
                    
                    HStack {
                        Text(isEditingThreats ? "Editing Threats..." : "Threat Levels")
                            .font(.headline)
                            .fontWeight(.heavy)
                            .padding(.leading)
                            .padding(.top)
                        Spacer()
                        Button {
                            isEditingThreats.toggle()
                        } label: {
                            Image(systemName: isEditingThreats ? "arrowshape.turn.up.backward" : "square.and.pencil")
                                .padding(.trailing)
                                .foregroundColor(.accentColor)
                        }
                    }
                    
                    Divider()
                        .padding(.horizontal)
                    
                    if isEditingThreats {
                        EditThreatsView(warbandVM: warbandVM, warband: warband)
                            .padding(.horizontal)
                    } else {
                        ThreatLevelsView(warbandVM: warbandVM, warband: warband)
                            .padding(.horizontal)
                    }
                }
                
                Group {
                    
                    FriendsKnownView(warbandVM: warbandVM, warband: warband)
                    
                    HiddenLocationsView(warbandVM: warbandVM, warband: warband)
                    
                    EquipmentStashView(warbandVM: warbandVM, warband: warband)
                    
                    BackpackView(warbandVM: warbandVM, warband: warband)
                }
                
                
            }
        }
        .navigationTitle(warband.name ?? "New Warband")
        .onAppear {
            warbandVM.loadWarbandData(warband: warband)
        }
    }
}

struct WarbandDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let previewWarband = Warband(context: viewContext)
        previewWarband.name = "The Brightguard"
        let newThreat = Threat(context: viewContext)
        newThreat.name = "The Ruin Within"
        newThreat.level = 5
        previewWarband.firstThreat = newThreat
        
        return WarbandDetailView(warbandVM: WarbandViewModel(), warband: previewWarband)
    }
}

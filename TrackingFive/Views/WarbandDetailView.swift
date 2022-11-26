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
    @State var isEditingThreats: Bool = false
    @State var isAddingFriend: Bool = false
    @State var isAddingLocation: Bool = false

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
                    HStack {
                        Text("Friends Known")
                            .font(.headline)
                            .fontWeight(.heavy)
                            .padding(.leading)
                            .padding(.top)
                        Spacer()
                        Button {
                            isAddingFriend.toggle()
                        } label: {
                            Image(systemName: "plus.circle")
                                .padding(.trailing)
                                .foregroundColor(.accentColor)
                        }
                    }
                    
                    Divider()
                        .padding(.horizontal)
                    
                    FriendsKnownView(warbandVM: warbandVM, warband: warband, isAddingFriend: $isAddingFriend)
                        .padding(.horizontal)
                    
                    HStack {
                        Text("Hidden Locations")
                            .font(.headline)
                            .fontWeight(.heavy)
                            .padding(.leading)
                            .padding(.top)
                        Spacer()
                        Button {
                            isAddingLocation.toggle()
                        } label: {
                            Image(systemName: "plus.circle")
                                .padding(.trailing)
                                .foregroundColor(.accentColor)
                        }
                    }
                    
                    Divider()
                        .padding(.horizontal)
                    
                    HiddenLocationsView(warbandVM: warbandVM, warband: warband, isAddingLocation: $isAddingLocation)
                        .padding(.horizontal)
                    
                    HStack {
                        Text("Equipment Stash")
                            .font(.headline)
                            .fontWeight(.heavy)
                            .padding(.leading)
                            .padding(.top)
                        Spacer()
                        NavigationLink {
                            CreateItemView(warbandVM: warbandVM, warband: warband, placement: .stash)
                        } label: {
                            Image(systemName: "plus.circle")
                                .padding(.trailing)
                                .foregroundColor(.accentColor)
                        }
                    }
                    
                    Divider()
                        .padding(.horizontal)
                    
                    EquipmentStashView(warbandVM: warbandVM, warband: warband)
                        .padding(.horizontal)
                    
                }
                
                Group {
                    HStack {
                        Text("Backpack")
                            .font(.headline)
                            .fontWeight(.heavy)
                            .padding(.leading)
                            .padding(.top)
                        Spacer()
                        NavigationLink {
                            CreateItemView(warbandVM: warbandVM, warband: warband, placement: .backpack)
                        } label: {
                            Image(systemName: "plus.circle")
                                .padding(.trailing)
                                .foregroundColor(.accentColor)
                        }
                    }
                    
                    Divider()
                        .padding(.horizontal)
                    
                    BackpackView(warbandVM: warbandVM, warband: warband)
                        .padding(.horizontal)
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

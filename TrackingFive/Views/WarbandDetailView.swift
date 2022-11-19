//
//  WarbandDetailView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/14/22.
//

import SwiftUI

struct WarbandDetailView: View {
    @ObservedObject var warbandVM: WarbandViewModel
    var warband: Warband

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
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
            }
        }.navigationTitle(warband.name ?? "New Warband")
    }
}

struct WarbandDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let previewWarband = Warband(context: viewContext)
        previewWarband.name = "The Brightguard"
        
        return WarbandDetailView(warbandVM: WarbandViewModel(), warband: previewWarband)
    }
}

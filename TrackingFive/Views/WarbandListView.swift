//
//  WarbandListView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/12/22.
//

import SwiftUI

struct WarbandListView: View {
    @ObservedObject var warbandVM: WarbandViewModel
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Warband.name, ascending: true)],
        animation: .default)
    private var warbands: FetchedResults<Warband>
    
    var body: some View {
        List {
            Section("Your Warbands") {
                ForEach(warbands) { warband in
                    NavigationLink {
                        //
                    } label: {
                        Text(warband.name!)
                    }
                }
            }
            .navigationTitle("Five Leagues From the Borderlands")
        }
    }
}

struct WarbandListView_Previews: PreviewProvider {
    static var previews: some View {
        WarbandListView(warbandVM: WarbandViewModel())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

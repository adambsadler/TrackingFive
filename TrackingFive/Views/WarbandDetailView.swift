//
//  WarbandDetailView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/14/22.
//

import SwiftUI

struct WarbandDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var warbandVM: WarbandViewModel
    @ObservedObject var warband: Warband

    var body: some View {
        ScrollView(showsIndicators: false) {
            Text(warband.name ?? "New Warband")
                .font(.largeTitle)
                .fontWeight(.heavy)
        }
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

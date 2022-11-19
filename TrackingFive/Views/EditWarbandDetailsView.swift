//
//  EditWarbandDetailsView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/19/22.
//

import SwiftUI

struct EditWarbandDetailsView: View {
    @ObservedObject var warbandVM: WarbandViewModel
    var warband: Warband
    
    var body: some View {
        Text("Edit Warband Details")
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

//
//  CrewListView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/14/22.
//

import SwiftUI

struct CrewListView: View {
    var body: some View {
        HeaderView(size: .large, text: "Coming Soon!", widthPercentage: UIDevice.current.userInterfaceIdiom == .pad ? 0.6 : 0.75, height: 60)
    }
}

struct CrewListView_Previews: PreviewProvider {
    static var previews: some View {
        CrewListView()
    }
}

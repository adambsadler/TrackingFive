//
//  ContentView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/12/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var warbandVM = WarbandViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 50) {
                Text("Choose A Game")
                    .font(.title)
                    .fontWeight(.semibold)
                
                NavigationLink {
                    WarbandListView(warbandVM: warbandVM)
                } label: {
                    Text("Five Leagues \nFrom the Borderlands")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.brown)
                        .cornerRadius(15)
                }

                Text("More to come...")
                    .font(.headline)
                
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

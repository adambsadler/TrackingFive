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
    
    @StateObject var warbandVM = WarbandViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 50) {
                Spacer()
                
                Text("Tracking Five")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 30)
                        NavigationLink {
                            WarbandListView(warbandVM: warbandVM)
                        } label: {
                            Image("FiveLeaguesCover")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(15)
                                .frame(maxWidth: 250)
                                .shadow(radius: 15)
                                .padding()
                                .padding(.leading)
                                
                        }
                        
                        NavigationLink {
                            CrewListView()
                        } label: {
                            Image("FiveParsecsCover")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(15)
                                .frame(maxWidth: 250)
                                .shadow(radius: 15)
                                .padding()
                                .padding(.trailing)
                        }
                        
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 25)
                    }
                }
                Text("Choose a Game")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
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

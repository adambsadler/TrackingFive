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
                
                HeaderView(size: .large, text: "Tracking Five", widthPercentage: warbandVM.isUsingIpad() ? 0.6 : 0.75, height: 60)
                
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
                                .frame(maxWidth: warbandVM.isUsingIpad() ? 600 : 250)
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
                                .frame(maxWidth: warbandVM.isUsingIpad() ? 600 : 250)
                                .shadow(radius: 15)
                                .padding()
                                .padding(.trailing)
                        }
                        
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 25)
                    }
                }
                
                HeaderView(size: .largeFlipped, text: "Choose a Game", widthPercentage: warbandVM.isUsingIpad() ? 0.6 : 0.75, height: 60)
                
                
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

//
//  WarbandListView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/12/22.
//

import SwiftUI

struct WarbandListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var warbandVM: WarbandViewModel
    @State var showingCreateView = false
    @State var newWarbandName = ""
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Warband.name, ascending: true)],
        animation: .default)
    private var warbands: FetchedResults<Warband>
    
    var body: some View {
        List {
            Section("Your Warbands") {
                ForEach(warbands) { warband in
                    NavigationLink {
                        WarbandDetailView(warbandVM: warbandVM, warband: warband)
                    } label: {
                        Text(warband.name!)
                    }
                }
                .onDelete(perform: deleteWarband)
            }
        }.toolbar {
            ToolbarItem {
                Button {
                    showingCreateView.toggle()
                } label: {
                    Text("Create a Warband")
                        .font(.subheadline)
                }

            }
        }
        .alert("Create New Warband", isPresented: $showingCreateView) {
            TextField("Warband Name", text: $newWarbandName)
            Button("Create") {
                warbandVM.createWarband(name: newWarbandName)
                newWarbandName = ""
            }
            Button("Cancel", role: .cancel) {
                showingCreateView.toggle()
                newWarbandName = ""
            }
        } message: {
            Text("Enter the name of your new warband.")
        }

    }
    
    private func deleteWarband(offsets: IndexSet) {
        withAnimation {
            offsets.map { warbands[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let error = error as NSError
                print(error.localizedDescription)
            }
        }
    }
}



struct WarbandListView_Previews: PreviewProvider {
    static var previews: some View {
        WarbandListView(warbandVM: WarbandViewModel())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

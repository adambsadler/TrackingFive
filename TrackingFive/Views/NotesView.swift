//
//  NotesView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/26/22.
//

import SwiftUI

struct NotesView: View {
    @ObservedObject var warbandVM: WarbandViewModel
    @ObservedObject var warband: Warband
    @State var isShowingNote: Bool = false
    @State var isAddingNote: Bool = false
    @State var newNoteContent: String = ""
    
    var body: some View {
        VStack {
            ZStack {
                HeaderView(size: .medium, text: "Notes", widthPercentage: 0.5, height: 40)
                    .padding(.top)
                HStack {
                    Spacer()
                    Button {
                        withAnimation {
                            isShowingNote.toggle()
                        }
                    } label: {
                        Image(systemName: isShowingNote ? "eye" : "eye.slash")
                            .padding(.trailing)
                            .foregroundColor(isShowingNote ? .accentColor : .gray)
                    }
                    Button {
                        isAddingNote.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
                .padding(.trailing)
            }
            
            
            if isShowingNote {
                ForEach(warbandVM.notes, id: \.self) { note in
                    if let content = note.content {
                        HStack {
                            Text("• \(content)")
                            Spacer()
                            Button {
                                warbandVM.deleteNote(note: note)
                            } label: {
                                Image(systemName: "x.circle.fill")
                                    .foregroundColor(.red)
                                    .padding(.trailing)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 5)
                    }
                }
            }
        }
        
        .alert("Add a Note", isPresented: $isAddingNote) {
            TextField("Friend Name", text: $newNoteContent)
                .disableAutocorrection(true)
            Button("Add") {
                warbandVM.createNote(content: newNoteContent, warband: warband)
                newNoteContent = ""
            }
            Button("Cancel", role: .cancel) {
                isAddingNote.toggle()
                newNoteContent = ""
            }
        } message: {
            Text("Enter the the content of your note.")
        }
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let previewWarband = Warband(context: viewContext)
        previewWarband.name = "The Brightguard"
        
        return NotesView(warbandVM: WarbandViewModel(), warband: previewWarband, isShowingNote: true, isAddingNote: false)
    }
}

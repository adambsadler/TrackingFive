//
//  FriendsKnownView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/22/22.
//

import SwiftUI

struct FriendsKnownView: View {
    @ObservedObject var warbandVM: WarbandViewModel
    @ObservedObject var warband: Warband
    @State var isAddingFriend: Bool = false
    @State var newFriendName: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Friends Known")
                    .font(.headline)
                    .fontWeight(.heavy)
                    .padding(.top)
                Spacer()
                Button {
                    isAddingFriend.toggle()
                } label: {
                    Image(systemName: "plus.circle")
                        .foregroundColor(.accentColor)
                }
            }
            
            Divider()
            
            ForEach(warbandVM.friends, id: \.self) { friend in
                if let friendName = friend.name {
                    HStack {
                        Text("• \(friendName)")
                        Spacer()
                        Button {
                            warbandVM.deleteFriend(friend: friend)
                        } label: {
                            Image(systemName: "x.circle.fill")
                                .foregroundColor(.red)
                                .padding(.trailing)
                        }
                    }
                    .padding(.bottom, 5)
                }
            }
        }
        .padding(.horizontal)
        .alert("Add a Friend", isPresented: $isAddingFriend) {
            TextField("Friend Name", text: $newFriendName)
                .disableAutocorrection(true)
            Button("Add") {
                warbandVM.createFriend(name: newFriendName, warband: warband)
                newFriendName = ""
            }
            Button("Cancel", role: .cancel) {
                isAddingFriend.toggle()
                newFriendName = ""
            }
        } message: {
            Text("Enter the name of the new friend.")
        }
    }
}

struct FriendsKnownView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let previewWarband = Warband(context: viewContext)
        previewWarband.name = "The Brightguard"
        
        return FriendsKnownView(warbandVM: WarbandViewModel(), warband: previewWarband, isAddingFriend: false)
    }
}

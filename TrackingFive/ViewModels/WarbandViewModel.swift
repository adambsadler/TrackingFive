//
//  WarbandViewModel.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/12/22.
//

import Foundation
import CoreData
import Combine

class WarbandViewModel: ObservableObject {
    let context = PersistenceController.shared.container.viewContext
    
    @Published var friends: [Friend] = []
    @Published var hiddenLocations: [HiddenLocation] = []
    
    func loadWarbandData(warband: Warband) {
        getWarbandFriends(warband: warband)
        getHiddenLocations(warband: warband)
    }
    
    func saveData() {
        do {
            try context.save()
        } catch {
            let error = error as NSError
            print("Error saving data: \(error.localizedDescription)")
        }
    }
    
    func createWarband(name: String) {
        let newWarband = Warband(context: context)
        newWarband.name = name
        
        saveData()
    }
    
    func createThreat(name: String, number: ThreatNumber, warband: Warband) {
        let newThreat = Threat(context: context)
        newThreat.name = name
        
        switch number {
        case .first:
            warband.firstThreat = newThreat
        case .second:
            warband.secondThreat = newThreat
        case .third:
            warband.thirdThreat = newThreat
        }
        
        saveData()
    }
    
    func increaseThreatLevel(threat: Threat) {
        if threat.level < 9 {
            DispatchQueue.main.async {
                threat.level += 1
            }
        }
        
        saveData()
    }
    
    func decreaseThreatLevel(threat: Threat) {
        if threat.level > 0 {
            DispatchQueue.main.async {
                threat.level -= 1
            }
        }
        
        saveData()
    }
    
    func deleteThreat(threat: Threat) {
        context.delete(threat)
        
        saveData()
    }
    
    func createFriend(name: String, warband: Warband) {
        let newFriend = Friend(context: context)
        newFriend.name = name
        warband.addToFriends(newFriend)
        
        friends.append(newFriend)
        
        saveData()
    }
    
    func deleteFriend(friend: Friend, warband: Warband) {
        friends.removeAll { savedFriend in
            friend == savedFriend
        }
        
        context.delete(friend)
        
        saveData()
    }
    
    func createHiddenLocation(name: String, warband: Warband) {
        let newHiddenLocation = HiddenLocation(context: context)
        newHiddenLocation.name = name
        warband.addToHiddenLocations(newHiddenLocation)
        
        hiddenLocations.append(newHiddenLocation)
        
        saveData()
    }
    
    func deleteHiddenLocation(location: HiddenLocation, warband: Warband) {
        hiddenLocations.removeAll { savedLocation in
            location == savedLocation
        }
        
        context.delete(location)
        
        saveData()
    }
    
    func getWarbandFriends(warband: Warband) {
        friends.removeAll()
        
        let fetchRequest: NSFetchRequest<Friend>
        fetchRequest = Friend.fetchRequest()
        
        do {
            let warbandFriends = try context.fetch(fetchRequest)
            
            for friend in warbandFriends {
                if friend.ofWarband == warband {
                    friends.append(friend)
                }
            }
        } catch {
            let error = error as NSError
            print("Error fetching freind array: \(error)")
        }
    }
    
    func getHiddenLocations(warband: Warband) {
        hiddenLocations.removeAll()
        
        let fetchRequest: NSFetchRequest<HiddenLocation>
        fetchRequest = HiddenLocation.fetchRequest()
        
        do {
            let warbandLocations = try context.fetch(fetchRequest)
            
            for location in warbandLocations {
                if location.ofWarband == warband {
                    hiddenLocations.append(location)
                }
            }
        } catch {
            let error = error as NSError
            print("Error fetching hidden locations: \(error)")
        }
    }
}

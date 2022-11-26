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
    
    @Published var heroes: [Hero] = []
    @Published var followers: [Follower] = []
    @Published var friends: [Friend] = []
    @Published var hiddenLocations: [HiddenLocation] = []
    @Published var stashedItems: [EquipmentItem] = []
    @Published var stashedWeapons: [Weapon] = []
    @Published var stashedArmor: [Armor] = []
    @Published var itemsInBackpack: [EquipmentItem] = []
    @Published var weaponsInBackpack: [Weapon] = []
    @Published var armorInBackpack: [Armor] = []
    
    func loadWarbandData(warband: Warband) {
        getWarbandFriends(warband: warband)
        getHiddenLocations(warband: warband)
        getStashedItems(warband: warband)
        getStashedWeapons(warband: warband)
        getStashedArmor(warband: warband)
        getBackpackItems(warband: warband)
        getBackpackWeapons(warband: warband)
        getBackpackArmor(warband: warband)
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
    
    func deleteFriend(friend: Friend) {
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
    
    func deleteHiddenLocation(location: HiddenLocation) {
        hiddenLocations.removeAll { savedLocation in
            location == savedLocation
        }
        
        context.delete(location)
        
        saveData()
    }
    
    func createItem(name: String, rules: String, placement: NewItemPlacement, warband: Warband? = nil, hero: Hero? = nil, follower: Follower? = nil) {
        let newItem = EquipmentItem(context: context)
        newItem.name = name
        newItem.rules = rules
        
        switch placement {
        case .stash:
            if let warband = warband {
                addItemToStash(item: newItem, warband: warband)
            } else {
                print("Unable to add new item to warband stash because there was no warband passed into \(#function)")
            }
        case .backpack:
            if let warband = warband {
                addItemToBackpack(item: newItem, warband: warband)
            } else {
                print("Unable to add new item to warband backpack because there was no warband passed into \(#function)")
            }
        case .hero:
            return
        case .follower:
            return
        }
        
        saveData()
    }
    
    func addItemToStash(item: EquipmentItem, warband: Warband) {
        stashedItems.append(item)
        warband.addToStashedItems(item)
        
        saveData()
    }
    
    func addItemToBackpack(item: EquipmentItem, warband: Warband) {
        itemsInBackpack.append(item)
        warband.addToItemsInBackpack(item)
        
        saveData()
    }
    
    func deleteItem(item: EquipmentItem) {
        stashedItems.removeAll { savedItem in
            item == savedItem
        }
        
        context.delete(item)
        
        saveData()
    }
    
    func createWeapon(name: String, type: WeaponType, range: Int, overcomeArmor: Int, overcomeToughness: Int, rules: String, placement: NewItemPlacement, warband: Warband? = nil, hero: Hero? = nil, follower: Follower? = nil) {
        let newWeapon = Weapon(context: context)
        newWeapon.name = name
        newWeapon.type = type.rawValue
        newWeapon.rules = rules
        newWeapon.overcomeArmor = Int64(overcomeArmor)
        newWeapon.overcomeToughness = Int64(overcomeToughness)
        newWeapon.range = Int64(range)
        
        switch placement {
        case .stash:
            if let warband = warband {
                addWeaponToStash(weapon: newWeapon, warband: warband)
            } else {
                print("Unable to add new weapon to warband stash because there was no warband passed into \(#function)")
            }
        case .backpack:
            if let warband = warband {
                addWeaponToBackpack(weapon: newWeapon, warband: warband)
            } else {
                print("Unable to add new weapon to warband backpack because there was no warband passed into \(#function)")
            }
        case .hero:
            return
        case .follower:
            return
        }
        
        saveData()
    }
    
    func addWeaponToStash(weapon: Weapon, warband: Warband) {
        stashedWeapons.append(weapon)
        warband.addToStashedWeapons(weapon)
        
        saveData()
    }
    
    func addWeaponToBackpack(weapon: Weapon, warband: Warband) {
        weaponsInBackpack.append(weapon)
        warband.addToWeaponsInBackpack(weapon)
        
        saveData()
    }
    
    func deleteWeapon(weapon: Weapon) {
        stashedWeapons.removeAll { savedWeapon in
            weapon == savedWeapon
        }
        
        context.delete(weapon)
        
        saveData()
    }
    
    func createArmor(name: String, rating: Int, rules: String, placement: NewItemPlacement, warband: Warband? = nil, hero: Hero? = nil, follower: Follower? = nil) {
        let newArmor = Armor(context: context)
        newArmor.name = name
        newArmor.rating = Int64(rating)
        newArmor.rules = rules
        
        switch placement {
        case .stash:
            if let warband = warband {
                addArmorToStash(armor: newArmor, warband: warband)
            } else {
                print("Unable to add new armor to warband stash because there was no warband passed into \(#function)")
            }
        case .backpack:
            if let warband = warband {
                addArmorToBackpack(armor: newArmor, warband: warband)
            } else {
                print("Unable to add new armor to warband backpack because there was no warband passed into \(#function)")
            }
        case .hero:
            return
        case .follower:
            return
        }
        
        saveData()
    }
    
    func addArmorToStash(armor: Armor, warband: Warband) {
        stashedArmor.append(armor)
        warband.addToStashedArmor(armor)
        
        saveData()
    }
    
    func addArmorToBackpack(armor: Armor, warband: Warband) {
        armorInBackpack.append(armor)
        warband.addToArmorInBackpack(armor)
        
        saveData()
    }
    
    func deleteArmor(armor: Armor) {
        stashedArmor.removeAll { savedArmor in
            armor == savedArmor
        }
        
        context.delete(armor)
        
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
    
    func getStashedItems(warband: Warband) {
        stashedItems.removeAll()
        
        let fetchRequest: NSFetchRequest<EquipmentItem>
        fetchRequest = EquipmentItem.fetchRequest()
        
        do {
            let warbandStashedItems = try context.fetch(fetchRequest)
            
            for stashedItem in warbandStashedItems {
                if stashedItem.inStash == warband {
                    stashedItems.append(stashedItem)
                }
            }
        } catch {
            let error = error as NSError
            print("Error fetching stashed items: \(error)")
        }
    }
    
    func getBackpackItems(warband: Warband) {
        itemsInBackpack.removeAll()
        
        let fetchRequest: NSFetchRequest<EquipmentItem>
        fetchRequest = EquipmentItem.fetchRequest()
        
        do {
            let warbandBackpackItems = try context.fetch(fetchRequest)
            
            for backpackItem in warbandBackpackItems {
                if backpackItem.inBackpack == warband {
                    itemsInBackpack.append(backpackItem)
                }
            }
        } catch {
            let error = error as NSError
            print("Error fetching backpack items: \(error)")
        }
    }
    
    func getStashedWeapons(warband: Warband) {
        stashedWeapons.removeAll()
        
        let fetchRequest: NSFetchRequest<Weapon>
        fetchRequest = Weapon.fetchRequest()
        
        do {
            let warbandStashedWeapons = try context.fetch(fetchRequest)
            
            for stashedWeapon in warbandStashedWeapons {
                if stashedWeapon.inStash == warband {
                    stashedWeapons.append(stashedWeapon)
                }
            }
        } catch {
            let error = error as NSError
            print("Error fetching stashed weapons: \(error)")
        }
    }
    
    func getBackpackWeapons(warband: Warband) {
        weaponsInBackpack.removeAll()
        
        let fetchRequest: NSFetchRequest<Weapon>
        fetchRequest = Weapon.fetchRequest()
        
        do {
            let warbandBackpackWeapons = try context.fetch(fetchRequest)
            
            for backpackWeapon in warbandBackpackWeapons {
                if backpackWeapon.inBackpack == warband {
                    weaponsInBackpack.append(backpackWeapon)
                }
            }
        } catch {
            let error = error as NSError
            print("Error fetching backpack weapons: \(error)")
        }
    }
    
    func getStashedArmor(warband: Warband) {
        stashedArmor.removeAll()
        
        let fetchRequest: NSFetchRequest<Armor>
        fetchRequest = Armor.fetchRequest()
        
        do {
            let warbandStashedArmor = try context.fetch(fetchRequest)
            
            for armor in warbandStashedArmor {
                if armor.inStash == warband {
                    stashedArmor.append(armor)
                }
            }
        } catch {
            let error = error as NSError
            print("Error fetching stashed armor: \(error)")
        }
    }
    
    func getBackpackArmor(warband: Warband) {
        armorInBackpack.removeAll()
        
        let fetchRequest: NSFetchRequest<Armor>
        fetchRequest = Armor.fetchRequest()
        
        do {
            let warbandBackpackArmor = try context.fetch(fetchRequest)
            
            for backpackArmor in warbandBackpackArmor {
                if backpackArmor.inBackpack == warband {
                    armorInBackpack.append(backpackArmor)
                }
            }
        } catch {
            let error = error as NSError
            print("Error fetching backpack armor: \(error)")
        }
    }
    
}

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
    @Published var contracts: [Contract] = []
    @Published var notes: [Note] = []
    
    func loadWarbandData(warband: Warband) {
        getWarbandFriends(warband: warband)
        getHiddenLocations(warband: warband)
        getStashedItems(warband: warband)
        getStashedWeapons(warband: warband)
        getStashedArmor(warband: warband)
        getBackpackItems(warband: warband)
        getBackpackWeapons(warband: warband)
        getBackpackArmor(warband: warband)
        getContracts(warband: warband)
        getNotes(warband: warband)
        getHeroes(warband: warband)
        getFollowers(warband: warband)
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
    
    func createCharacter(warband: Warband, type: CharacterType, name: String, origin: String? = nil, agility: Int, speed: Int, dash: Int, combat: Int, toughness: Int, luck: Int, will: Int, casting: Int) {
        switch type {
        case .hero:
            let newHero = Hero(context: context)
            newHero.name = name
            newHero.origin = origin
            newHero.agility = Int64(agility)
            newHero.speed = Int64(speed)
            newHero.dashSpeed = Int64(dash)
            newHero.combatSkill = Int64(combat)
            newHero.toughness = Int64(toughness)
            newHero.luck = Int64(luck)
            newHero.will = Int64(will)
            newHero.casting = Int64(casting)
            warband.addToHeroes(newHero)
            
            saveData()
        case .follower:
            let newFollower = Follower(context: context)
            newFollower.name = name
            newFollower.agility = Int64(agility)
            newFollower.speed = Int64(speed)
            newFollower.dashSpeed = Int64(dash)
            newFollower.combatSkill = Int64(combat)
            newFollower.toughness = Int64(toughness)
            newFollower.luck = Int64(luck)
            newFollower.will = Int64(will)
            warband.addToFollowers(newFollower)
            
            saveData()
        }
    }
    
    func updateHero(hero: Hero, name: String, origin: String, agility: Int, speed: Int, dash: Int, combat: Int, toughness: Int, luck: Int, will: Int, casting: Int, experience: Int) {
        hero.name = name
        hero.origin = origin
        hero.agility = Int64(agility)
        hero.speed = Int64(speed)
        hero.dashSpeed = Int64(dash)
        hero.combatSkill = Int64(combat)
        hero.toughness = Int64(toughness)
        hero.luck = Int64(luck)
        hero.will = Int64(will)
        hero.casting = Int64(casting)
        hero.experience = Int64(experience)
        
        saveData()
    }
    
    func addSkillToHero(hero: Hero, name: String?, rules: String?) {
        let skill = Skill(context: context)
        skill.name = name
        skill.rules = rules
        hero.addToSkills(skill)
        
        saveData()
    }
    
    func deleteSkill(skill: Skill) {
        context.delete(skill)
        
        saveData()
    }
    
    func addSpellToHero(hero: Hero, incantation: Int, name: String?, rules: String?) {
        let spell = Spell(context: context)
        spell.incantation = Int64(incantation)
        spell.name = name
        spell.rules = rules
        hero.addToSpells(spell)
        
        saveData()
    }
    
    func deleteSpell(spell: Spell) {
        context.delete(spell)
        
        saveData()
    }
    
    func deleteHero(hero: Hero) {
        heroes.removeAll { savedHero in
            hero == savedHero
        }
        
        context.delete(hero)
        
        saveData()
    }
    
    func updateFollower(follower: Follower, name: String, agility: Int, speed: Int, dash: Int, combat: Int, toughness: Int, luck: Int, will: Int) {
        follower.name = name
        follower.agility = Int64(agility)
        follower.speed = Int64(speed)
        follower.dashSpeed = Int64(dash)
        follower.combatSkill = Int64(combat)
        follower.toughness = Int64(toughness)
        follower.luck = Int64(luck)
        follower.will = Int64(will)
        
        saveData()
    }
    
    func promoteFollower(warband: Warband, follower: Follower) {
        let newHero = Hero(context: context)
        newHero.name = follower.name
        newHero.agility = follower.agility
        newHero.speed = follower.speed
        newHero.dashSpeed = follower.dashSpeed
        newHero.combatSkill = follower.combatSkill
        newHero.toughness = follower.toughness
        newHero.luck = follower.luck
        newHero.will = follower.will
        warband.addToHeroes(newHero)
        
        context.delete(follower)
        saveData()
    }
    
    func addSkillToFollower(follower: Follower, name: String?, rules: String?) {
        let skill = Skill(context: context)
        skill.name = name
        skill.rules = rules
        follower.addToSkills(skill)
        
        saveData()
    }
    
    func deleteFollower(follower: Follower) {
        followers.removeAll { savedFollower in
            follower == savedFollower
        }
        
        context.delete(follower)
        
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
    
    func createNote(content: String, warband: Warband) {
        let newNote = Note(context: context)
        newNote.content = content
        warband.addToNotes(newNote)
        
        notes.append(newNote)
        
        saveData()
    }
    
    func deleteNote(note: Note) {
        notes.removeAll { savedNote in
            note == savedNote
        }
        
        context.delete(note)
        
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
            if let hero = hero {
                addItemToHero(item: newItem, hero: hero)
            } else {
                print("Unable to add new item to hero because there was no hero passed into \(#function)")
            }
        case .follower:
            if let follower = follower {
                addItemToFollower(item: newItem, follower: follower)
            } else {
                print("Unable to add new item to follower because there was no follower passed into \(#function)")
            }
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
    
    func addItemToHero(item: EquipmentItem, hero: Hero) {
        hero.addToItems(item)
        
        saveData()
    }
    
    func addItemToFollower(item: EquipmentItem, follower: Follower) {
        follower.addToItems(item)
        
        saveData()
    }
    
    func deleteItem(item: EquipmentItem) {
        stashedItems.removeAll { savedItem in
            item == savedItem
        }
        
        itemsInBackpack.removeAll { savedItem in
            item == savedItem
        }
        
        context.delete(item)
        
        saveData()
    }
    
    func moveItem(warband: Warband, item: EquipmentItem, from: NewItemPlacement, fromHero: Hero? = nil, fromFollower: Follower? = nil, to: NewItemPlacement, toHero: Hero? = nil, toFollower: Follower? = nil) {
        switch from {
        case .stash:
            stashedItems.removeAll { savedItem in
                item == savedItem
            }
            
            warband.removeFromStashedItems(item)
            saveData()
            
        case .backpack:
            itemsInBackpack.removeAll { savedItem in
                item == savedItem
            }
            
            warband.removeFromItemsInBackpack(item)
            saveData()
            
        case .hero:
            if let hero = fromHero {
                hero.removeFromItems(item)
                saveData()
            } else {
                print("Unable to remove item from hero because there was no hero passed into \(#function)")
            }
        case .follower:
            if let follower = fromFollower {
                follower.removeFromItems(item)
                saveData()
            } else {
                print("Unable to remove item from follower because there was no follower passed into \(#function)")
            }
        }
        
        switch to {
        case .stash:
            addItemToStash(item: item, warband: warband)
        case .backpack:
            addItemToBackpack(item: item, warband: warband)
        case .hero:
            if let hero = toHero {
                addItemToHero(item: item, hero: hero)
            } else {
                print("Unable to move item to hero because there was no hero passed into \(#function)")
            }
        case .follower:
            if let follower = toFollower {
                addItemToFollower(item: item, follower: follower)
            } else {
                print("Unable to move item to follower because there was no follower passed into \(#function)")
            }
        }
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
            if let hero = hero {
                addWeaponToHero(weapon: newWeapon, hero: hero)
            } else {
                print("Unable to add new weapon to hero because there was no hero passed into \(#function)")
            }
        case .follower:
            if let follower = follower {
                addWeaponToFollower(weapon: newWeapon, follower: follower)
            } else {
                print("Unable to add new weapon to follower because there was no follower passed into \(#function)")
            }
        }
        
        saveData()
    }
    
    func updateWeapon(weapon: Weapon, range: Int, overcomeArmor: Int, overcomeToughness: Int, rules: String) {
        weapon.range = Int64(range)
        weapon.overcomeArmor = Int64(overcomeArmor)
        weapon.overcomeToughness = Int64(overcomeToughness)
        weapon.rules = rules
        
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
    
    func addWeaponToHero(weapon: Weapon, hero: Hero) {
        hero.addToWeapons(weapon)
        
        saveData()
    }
    
    func addWeaponToFollower(weapon: Weapon, follower: Follower) {
        follower.addToWeapons(weapon)
        
        saveData()
    }
    
    func deleteWeapon(weapon: Weapon) {
        stashedWeapons.removeAll { savedWeapon in
            weapon == savedWeapon
        }
        
        weaponsInBackpack.removeAll { savedWeapon in
            weapon == savedWeapon
        }
        
        context.delete(weapon)
        
        saveData()
    }
    
    func moveWeapon(warband: Warband, weapon: Weapon, from: NewItemPlacement, fromHero: Hero? = nil, fromFollower: Follower? = nil, to: NewItemPlacement, toHero: Hero? = nil, toFollower: Follower? = nil) {
        switch from {
        case .stash:
            stashedWeapons.removeAll { savedWeapon in
                weapon == savedWeapon
            }
            
            warband.removeFromStashedWeapons(weapon)
            saveData()
            
        case .backpack:
            weaponsInBackpack.removeAll { savedWeapon in
                weapon == savedWeapon
            }
            
            warband.removeFromWeaponsInBackpack(weapon)
            saveData()
            
        case .hero:
            if let hero = fromHero {
                hero.removeFromWeapons(weapon)
                saveData()
            } else {
                print("Unable to remove weapon from hero because there was no hero passed into \(#function)")
            }
        case .follower:
            if let follower = fromFollower {
                follower.removeFromWeapons(weapon)
                saveData()
            } else {
                print("Unable to remove weapon from follower because there was no follower passed into \(#function)")
            }
        }
        
        switch to {
        case .stash:
            addWeaponToStash(weapon: weapon, warband: warband)
        case .backpack:
            addWeaponToBackpack(weapon: weapon, warband: warband)
        case .hero:
            if let hero = toHero {
                addWeaponToHero(weapon: weapon, hero: hero)
            } else {
                print("Unable to move weapon to hero because there was no hero passed into \(#function)")
            }
        case .follower:
            if let follower = toFollower {
                addWeaponToFollower(weapon: weapon, follower: follower)
            } else {
                print("Unable to move item to follower because there was no follower passed into \(#function)")
            }
        }
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
            if let hero = hero {
                addArmorToHero(armor: newArmor, hero: hero)
            } else {
                print("Unable to add new armor to hero because there was no hero passed into \(#function)")
            }
        case .follower:
            if let follower = follower {
                addArmorToFollower(armor: newArmor, follower: follower)
            } else {
                print("Unable to add new armor to follower because there was no follower passed into \(#function)")
            }
        }
        
        saveData()
    }
    
    func updateArmor(armor: Armor, rating: Int, rules: String) {
        armor.rating = Int64(rating)
        armor.rules = rules
        
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
        
        armorInBackpack.removeAll { savedArmor in
            armor == savedArmor
        }
        
        context.delete(armor)
        
        saveData()
    }
    
    func addArmorToHero(armor: Armor, hero: Hero) {
        hero.armor = armor
        
        saveData()
    }
    
    func addArmorToFollower(armor: Armor, follower: Follower) {
        follower.armor = armor
        
        saveData()
    }
    
    func moveArmor(warband: Warband, armor: Armor, from: NewItemPlacement, fromHero: Hero? = nil, fromFollower: Follower? = nil, to: NewItemPlacement, toHero: Hero? = nil, toFollower: Follower? = nil) {
        switch from {
        case .stash:
            stashedArmor.removeAll { savedArmor in
                armor == savedArmor
            }
            
            warband.removeFromStashedArmor(armor)
            saveData()
            
        case .backpack:
            armorInBackpack.removeAll { savedArmor in
                armor == savedArmor
            }
            
            warband.removeFromArmorInBackpack(armor)
            saveData()
            
        case .hero:
            if let hero = fromHero {
                armor.ofHero = nil
                hero.armor = nil
                saveData()
            } else {
                print("Unable to remove armor from hero because there was no hero passed into \(#function)")
            }
        case .follower:
            if let follower = fromFollower {
                armor.ofFollower = nil
                follower.armor = nil
                saveData()
            } else {
                print("Unable to remove armor from follower because there was no follower passed into \(#function)")
            }
        }
        
        switch to {
        case .stash:
            addArmorToStash(armor: armor, warband: warband)
        case .backpack:
            addArmorToBackpack(armor: armor, warband: warband)
        case .hero:
            if let hero = toHero {
                addArmorToHero(armor: armor, hero: hero)
            } else {
                print("Unable to move armor to hero because there was no hero passed into \(#function)")
            }
        case .follower:
            if let follower = toFollower {
                addArmorToFollower(armor: armor, follower: follower)
            } else {
                print("Unable to move armor to follower because there was no follower passed into \(#function)")
            }
        }
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
    
    func getContracts(warband: Warband) {
        contracts.removeAll()
        
        let fetchRequest: NSFetchRequest<Contract>
        fetchRequest = Contract.fetchRequest()
        
        do {
            let warbandContracts = try context.fetch(fetchRequest)
            
            for contract in warbandContracts {
                if contract.ofWarband == warband {
                    contracts.append(contract)
                }
            }
        } catch {
            let error = error as NSError
            print("Error fetching contracts: \(error)")
        }
    }
    
    func getNotes(warband: Warband) {
        notes.removeAll()
        
        let fetchRequest: NSFetchRequest<Note>
        fetchRequest = Note.fetchRequest()
        
        do {
            let warbandNotes = try context.fetch(fetchRequest)
            
            for note in warbandNotes {
                if note.ofWarband == warband {
                    notes.append(note)
                }
            }
        } catch {
            let error = error as NSError
            print("Error fetching notes: \(error)")
        }
    }
    
    func getHeroes(warband: Warband) {
        heroes.removeAll()
        
        let fetchRequest: NSFetchRequest<Hero>
        fetchRequest = Hero.fetchRequest()
        
        do {
            let warbandHeroes = try context.fetch(fetchRequest)
            
            for hero in warbandHeroes {
                if hero.ofWarband == warband {
                    heroes.append(hero)
                }
            }
        } catch {
            let error = error as NSError
            print("Error fetching heroes: \(error)")
        }
    }
    
    func getFollowers(warband: Warband) {
        followers.removeAll()
        
        let fetchRequest: NSFetchRequest<Follower>
        fetchRequest = Follower.fetchRequest()
        
        do {
            let warbandFollowers = try context.fetch(fetchRequest)
            
            for follower in warbandFollowers {
                if follower.ofWarband == warband {
                    followers.append(follower)
                }
            }
        } catch {
            let error = error as NSError
            print("Error fetching followers: \(error)")
        }
    }
    
}

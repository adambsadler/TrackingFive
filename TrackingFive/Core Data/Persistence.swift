//
//  Persistence.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/12/22.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let newWarband = Warband(context: viewContext)
        newWarband.name = "The Brightguard"
        
        let newHero = Hero(context: viewContext)
        newHero.name = "Ransil"
        newWarband.addToHeroes(newHero)
        
        let newItem = EquipmentItem(context: viewContext)
        newItem.name = "2 Silvertree leaf (S,C)"
        newItem.rules = "Reroll post-game Injuries."
        newWarband.addToStashedItems(newItem)
        
        let newThreat = Threat(context: viewContext)
        newThreat.name = "The Ruin Within"
        newThreat.level = 5
        newWarband.firstThreat = newThreat
        
        let newQuest = Quest(context: viewContext)
        newQuest.task = "Rescue the prisoner"
        newQuest.location = "Wilderness"
        newQuest.rules = "Fight a Raid(Camp) scenario."
        newWarband.quest = newQuest
        
        let newContract = Contract(context: viewContext)
        newContract.name = "Locate item"
        newContract.reward = "3 Gold Marks"
        newContract.rules = "Defeate a Unique Foe in melee combat. Find item on 5+."
        newWarband.addToContracts(newContract)
        
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            print(error.localizedDescription)
        }
        return result
    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "TrackingFive")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                print(error.localizedDescription)
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func save() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error as NSError
                print(error)
            }
        }
    }
}

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
}

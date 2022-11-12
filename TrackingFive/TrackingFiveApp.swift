//
//  TrackingFiveApp.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/12/22.
//

import SwiftUI

@main
struct TrackingFiveApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

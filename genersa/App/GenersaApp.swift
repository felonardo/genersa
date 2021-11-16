//
//  GenersaApp.swift
//  Genersa
//
//  Created by Leo nardo on 22/10/21.
//

import SwiftUI

@main
struct GenersaApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(TripSettings(currency: Currency.allCurrencies.first!))
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}

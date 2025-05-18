//
//  LearnAppApp.swift
//  LearnApp
//
//  Created by Tobias Knaupp on 18.05.25.
//

import SwiftUI

@main
struct LearnAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

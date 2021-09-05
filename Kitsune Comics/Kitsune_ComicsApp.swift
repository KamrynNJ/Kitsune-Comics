//
//  Kitsune_ComicsApp.swift
//  Kitsune Comics
//
//  Created by Kamryn Jones on 9/4/21.
//

import SwiftUI

@main
struct Kitsune_ComicsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

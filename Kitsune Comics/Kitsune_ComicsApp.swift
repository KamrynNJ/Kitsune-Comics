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
    @StateObject var viewRouter = ViewRouter()
    var body: some Scene {
        WindowGroup {
            StartingScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

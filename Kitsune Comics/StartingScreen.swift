//
//  StartingScreen.swift
//  Kitsune Comics
//
//  Created by Kamryn Jones on 9/30/21.
//

import SwiftUI

struct StartingScreen: View {
    var body: some View {
        TabView {
            UpdateScreen()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(1)
            FavScreen()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
                .tag(2)
            StartingAddScreen()
                .tabItem {
                    Label("Add", systemImage: "plus.circle")
                }
                .tag(3)
            ContentView()
                .tabItem {
                    Label("List", systemImage: "list.dash")
                }
                .tag(4)
            SettingsScreen()
                .tabItem {
                    Label("Settings", systemImage: "gear.circle")
                }
                .tag(5)
        }
    }
}


struct StartingScreen_Previews: PreviewProvider {
    static var previews: some View {
        StartingScreen()
    }
}

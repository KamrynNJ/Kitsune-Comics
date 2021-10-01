//
//  StartingAddScreen.swift
//  Kitsune Comics
//
//  Created by Kamryn Jones on 9/30/21.
//

import SwiftUI

struct StartingAddScreen: View {
    var body: some View {
        TabView{        
            AddEntryScreen()
                .tabItem {
                    Label("Add", systemImage: "plus.circle")
                }
                .tag(1)
            WebScraper()
                .tabItem {
                    Label("Link Add", systemImage: "plus.circle.fill")
                }
                .tag(2)
        
        }
    }
}

struct StartingAddScreen_Previews: PreviewProvider {
    static var previews: some View {
        StartingAddScreen()
    }
}

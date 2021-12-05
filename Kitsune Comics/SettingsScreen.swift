//
//  HomeScreen.swift
//  Kitsune Comics
//
//  Created by Kamryn Jones on 9/5/21.
//

import SwiftUI

struct SettingsScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: WebThings.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \WebThings.title, ascending: true)])

    var enities: FetchedResults<WebThings>
    var web = WebThings()
    let placeholder = URL(string: "https://i.quotev.com/gcbuwion4kwa.jpg")
    var body: some View {
        VStack{
            Text("Settings")
                .font(.title)
            Text("Entry List Hard Copy")
                .font(.headline)
            ForEach(enities) {WebThings in
                let currentChapter = ChapterGetter(givenUrl: WebThings.link)
                let x = currentChapter.trimmingCharacters(in: .whitespacesAndNewlines)
                VStack{
                        Text("Title: \(WebThings.title)")
                        Text("Chapter: \(WebThings.chapter)")
                        Text("Chapter in link: \(x)")
                        Text("Link: \(WebThings.link)")
                        Spacer()
                        }
                    }
        }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen()
    }
}
}

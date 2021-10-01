//
//  AddEntryScreen.swift
//  Kitsune Comics
//
//  Created by Kamryn Jones on 9/5/21.
//

import SwiftUI

struct AddEntryScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment (\.presentationMode) var presentationMode
       
    let entryTypes = ["Webtoon", "Webnovel", "Manga"]
    
    @State var selectedTypeIndex = 0
    @State var numberOfSlices = 1
    @State var titleEntered = ""
    @State var imageEntered = ""
    @State var linkEntered = ""
    @State var chapterEntered = ""
    @State var showAddScreen = true
    @State var showFavScreen = false
    @State var showListScreen = false
    @State var showHomeScreen = false
    @State var showUpdateScreen = false
    @State var showOtherAddScreen = false
    @State private var showingAlert = false
    
    
    var body: some View {
            VStack{
            NavigationView {
                Form {
                    Section(header: Text("Entry Type")) {
                        Picker(selection: $selectedTypeIndex, label: Text("Entry Type")) {
                            ForEach(0 ..< entryTypes.count) {
                                    Text(self.entryTypes[$0]).tag($0)
                            }
                        }
                    }
                    
                    Section(header: Text("Title")) {
                        TextField("Entry Title", text: $titleEntered)
                    }
                    Section(header: Text("Image Link")) {
                        TextField("Entry Image Link", text: $imageEntered)
                    }
                    Section(header: Text("Link")) {
                        TextField("Entry Link", text: $linkEntered)
                    }
                    Section(header: Text("Chapter")) {
                        TextField("Entry Chapter", text: $chapterEntered)
                    }
                    Button(action: {
                        showingAlert = true
                        let newEntry = WebThings(context: viewContext)
                        newEntry.type = self.entryTypes[self.selectedTypeIndex]
                        newEntry.title = self.titleEntered
                        newEntry.image_link = self.imageEntered
                        newEntry.link = self.linkEntered
                        newEntry.chapter = self.chapterEntered
                        newEntry.id = UUID()
                        newEntry.favorite = false
                        do {
                            try viewContext.save()
                            showHomeScreen = true
                        } catch {
                            print(error.localizedDescription)
                        }
                    }) {
                        Text("Add Entry")
                    }
            }
                .navigationBarTitle("Add Entry")
                
                
        }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Entry Added")
                )
            }
            
            }
}
}

struct AddEntryScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddEntryScreen()

    }
}

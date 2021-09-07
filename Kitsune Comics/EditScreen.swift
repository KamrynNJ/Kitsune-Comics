//
//  AddEntryScreen.swift
//  Kitsune Comics
//
//  Created by Kamryn Jones on 9/5/21.
//

import SwiftUI

struct EditScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment (\.presentationMode) var presentationMode
    //@Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: WebThings.entity(), sortDescriptors: [])
    var editEnities: FetchedResults<WebThings>
    
    //@State var idString: UUID
    let webs: WebThings
    var idValue = ContentView()
       
    let entryTypes = ["Webtoon", "Webnovel", "Manga"]
    
    @State var newselectedTypeIndex = 0
    @State var numberOfSlices = 1
    @State var newtitleEntered = ""
    @State var newimageEntered = ""
    @State var newlinkEntered = ""
    @State var newchapterEntered = ""
    @State var showEditScreen = true
    @State var showHomeScreen = false
    
    
    var body: some View {
        if(showEditScreen){
            VStack{
            NavigationView {
                Form {
                    Section(header: Text("Entry Type")) {
                        Picker(selection: $newselectedTypeIndex, label: Text("Entry Type")) {
                            ForEach(0 ..< entryTypes.count) {
                                    Text(self.entryTypes[$0]).tag($0)
                            }
                        }
                    }
                    
                    Section(header: Text("Title")) {
                        TextField(webs.title, text: $newtitleEntered)
                    }
                    Section(header: Text("Image Link")) {
                        TextField("Entry Image Link", text: $newimageEntered)
                    }
                    Section(header: Text("Link")) {
                        TextField("Entry Link", text: $newlinkEntered)
                    }
                    Section(header: Text("Chapter")) {
                        TextField("Entry Chapter", text: $newchapterEntered)
                    }
                    Button(action: {
                        webs.type = self.entryTypes[self.newselectedTypeIndex]
                        if (!newtitleEntered.isEmpty){
                            webs.title = newtitleEntered
                        }
                        else{
                            webs.title = webs.title
                        }
                        if (!newimageEntered.isEmpty){
                            webs.image_link = newimageEntered
                        }
                        else{
                            webs.image_link = webs.image_link
                        }
                        if (!newlinkEntered.isEmpty){
                            webs.link = newlinkEntered
                        }
                        else{
                            webs.link = webs.link
                        }
                        if (!newchapterEntered.isEmpty){
                            webs.chapter = newchapterEntered
                        }
                        else{
                            webs.chapter = webs.chapter
                        }
                        do {
                            try viewContext.save()
                            showHomeScreen = true
                            presentationMode.wrappedValue.dismiss()
                        } catch {
                            print(error.localizedDescription)
                        }
                    }) {
                        Text("Edit Entry")
                    }
            }
                .navigationTitle("Edit Entry")
                
        }
            }
    }
}
}

struct EditScreen_Previews: PreviewProvider {
    static var previews: some View {
        let webs = WebThings()
        EditScreen(webs: webs)
    }
}

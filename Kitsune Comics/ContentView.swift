//
//  ContentView.swift
//  Kitsune Comics
//
//  Created by Kamryn Jones on 9/4/21.
//

import SwiftUI
import CoreData

struct SearchBar: View {
    @Binding var text: String
 
    @State private var isEditing = false
 
    var body: some View {
        HStack {
 
            TextField("Search ...", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
 
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
 
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
        .overlay(
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
         
                if isEditing {
                    Button(action: {
                    },label: {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 90)                    }).onTapGesture{
                        self.text = ""
                    }
                }
            }
        )
    }
}


struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: WebThings.entity(), sortDescriptors: [])

    var enities: FetchedResults<WebThings>
    //var web = WebThings()
   
    
    @State var showAddScreen = false
    @State var showFavScreen = false
    @State var showListScreen = true
    @State var showHomeScreen = false
    @State var showUpdateScreen = false
    @State var showEditScreen = false
    @State var searchText = ""
    @State var pressed = false
    

func updateEntity(WebThing: WebThings) {
        let newTitle = "\(WebThing.title)"
        viewContext.performAndWait {
            WebThing.title = newTitle
            try? viewContext.save()
        }
    }
    var body: some View {
        if (showListScreen){
            VStack{
            NavigationView {
                List{
                    SearchBar(text: $searchText)
                    ForEach(enities.filter({ searchText.isEmpty ? true : $0.title.contains(searchText) })) {WebThings in
                       HStack {
                           VStack(alignment: .leading) {
                            HStack{
                                Image(systemName: "placeholder image")
                                .data(url: URL(string: "\(WebThings.image_link)")!)
                                .frame(width:70)
                                VStack{
                                   Text("\(WebThings.title)")
                                    Text("\(WebThings.type)")
                                        .font(.subheadline)
                                    HStack{
                                        Text("Chapter: \(WebThings.chapter)")
                                        Link("Read",
                                              destination: URL(string: "\(WebThings.link)")!)
                                    }
                                }
                            }
                           }
                           Spacer()
                        Button(action: {
                            //pressed = true
                            showEditScreen = true
                            
                        }, label: {
                            Image(systemName: "square.and.pencil")
                                .font(.largeTitle)
                                //.imageScale(.large)
                        })
                        .buttonStyle(BorderlessButtonStyle())
                       }
                       .frame(height: 100)
                       .sheet(isPresented: $showEditScreen) {
                        EditScreen(webs: WebThings)
                           .environment(\.managedObjectContext, self.viewContext)
                           }
                       }//end of for loop
                    .onDelete { indexSet in
                               for index in indexSet {
                                   viewContext.delete(enities[index])
                               }
                               do {
                                   try viewContext.save()
                               } catch {
                                   print(error.localizedDescription)
                               }
                           }
                }
                    .navigationTitle("List")
                //Edit screen popup
//                    .sheet(isPresented: $showEditScreen) {
//                        EditScreen()
//                        .environment(\.managedObjectContext, self.viewContext)
//                        }
                    }
                HStack{
                    Button(action: {
                        showHomeScreen = true
                         showAddScreen = false
                         showFavScreen = false
                         showListScreen = false
                         showUpdateScreen = false
                        
                    }, label: {
                        Image(systemName: "house")
                            .font(.largeTitle)
                    })
                    Button(action: {
                        showFavScreen = true
                        showAddScreen = false
                        showListScreen = false
                        showHomeScreen = false
                        showUpdateScreen = false
                    }, label: {
                        Image(systemName: "star")
                            .font(.largeTitle)
                    })
                    Button(action: {
                        showAddScreen = true
                        showFavScreen = false
                        showListScreen = false
                        showHomeScreen = false
                        showUpdateScreen = false
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.largeTitle)
                    })
                    Button(action: {
                        showUpdateScreen = true
                        showAddScreen = false
                        showFavScreen = false
                        showListScreen = false
                        showHomeScreen = false
                    }, label: {
                        Image(systemName: "square.and.arrow.up")
                            .font(.largeTitle)
                    })
                    Button(action: {
                        showListScreen = true
                        showAddScreen = false
                        showFavScreen = false
                        showHomeScreen = false
                        showUpdateScreen = false
                    }, label: {
                        Image(systemName: "list.bullet")
                            .font(.largeTitle)
                    })
                    
                    
                }
            }
        }
        else if(showAddScreen){
            AddEntryScreen()
        }
        else if(showHomeScreen){
            HomeScreen()
        }
        else if(showUpdateScreen){
            UpdateScreen()
        }
        else if(showFavScreen){
            FavScreen()
        }
        
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
extension Image {
    func data(url:URL) -> Self {
        if let data = try? Data(contentsOf: url) {
            return Image(uiImage: UIImage(data: data)!)
                .resizable()
        }
        return self
            .resizable()
    }
}

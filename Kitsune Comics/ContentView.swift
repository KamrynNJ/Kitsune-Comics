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
//struct UpdatedAdded:View{
//    @Environment(\.managedObjectContext) private var viewContext
//    @Environment (\.presentationMode) var presentationMode
//    var asset: WebThings {
//        viewContext.object(with: assetId) as! WebThings
//        }
//
//    @FetchRequest(entity: WebThings.entity(), sortDescriptors: [])
//    var editEnities: FetchedResults<WebThings>
//
//    //@State var idString: UUID
//    //var idValue = ContentView()
//    @State var assetId: NSManagedObjectID
//
//    let entryTypes = ["Webtoon", "Webnovel", "Manga"]
//
//    @State var newselectedTypeIndex = 0
//    @State var numberOfSlices = 1
//    @State var newtitleEntered = ""
//    @State var newimageEntered = ""
//    @State var newlinkEntered = ""
//    @State var newchapterEntered = ""
//    @State var showFavScreen = false
//    @State var showHomeScreen = false
//    @State var showUpScreen = false
//    @State var count = 0
//
//    @State private var isPressed = false
//        
//        var body: some View {
//            let currentChapter = ChapterGetter(givenUrl: self.asset.link)
//            let x = currentChapter.trimmingCharacters(in: .whitespacesAndNewlines)
//            self.asset.update = (self.asset.chapter.compare(x) == .orderedSame) ? false : true
//           
//            
//            
//        }
//}
struct FavoritesAdded: View{
    @Environment(\.managedObjectContext) private var viewContext
    @Environment (\.presentationMode) var presentationMode
    var asset: WebThings {
        viewContext.object(with: assetId) as! WebThings
        }

    @FetchRequest(entity: WebThings.entity(), sortDescriptors: [])
    var editEnities: FetchedResults<WebThings>

    //@State var idString: UUID
    //var idValue = ContentView()
    @State var assetId: NSManagedObjectID

    let entryTypes = ["Webtoon", "Webnovel", "Manga"]

    @State var newselectedTypeIndex = 0
    @State var numberOfSlices = 1
    @State var newtitleEntered = ""
    @State var newimageEntered = ""
    @State var newlinkEntered = ""
    @State var newchapterEntered = ""
    @State var showFavScreen = false
    @State var showHomeScreen = false
    @State var count = 0

    @State private var isPressed = false
        
        var body: some View {
            Button(action: {
                if !(self.asset.favorite){
                    self.asset.favorite = true
                    showFavScreen = true
                    
                }
                else{
                    self.asset.favorite = false
                    showFavScreen = false
                }
                do{
                    try viewContext.save()
                }
                catch {
                    print(error.localizedDescription)
                }
            }, label: {
                if (self.asset.favorite){
                    Image(systemName: "star.fill")
                    .font(.largeTitle)
                }
                else{
                    Image(systemName: "star")
                    .font(.largeTitle)
                }
            })
            .buttonStyle(PlainButtonStyle())
            .foregroundColor(.yellow)
            
        }
}

struct EditScreenInCode: View{
    @Environment(\.managedObjectContext) private var viewContext
    @Environment (\.presentationMode) var presentationMode
    var asset: WebThings {
        viewContext.object(with: assetId) as! WebThings
        }

    @FetchRequest(entity: WebThings.entity(), sortDescriptors: [])
    var editEnities: FetchedResults<WebThings>
    
    //@State var idString: UUID
    //var idValue = ContentView()
    @State var assetId: NSManagedObjectID
       
    let entryTypes = ["Webtoon", "Webnovel", "Manga"]
    
    @State var newselectedTypeIndex = 0
    @State var numberOfSlices = 1
    @State var style = 0
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
                        TextField(self.asset.title, text: $newtitleEntered)
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
                        self.asset.type = self.entryTypes[self.newselectedTypeIndex]
                        if (!newtitleEntered.isEmpty){
                            self.asset.title = newtitleEntered
                        }
                        else{
                            self.asset.title = self.asset.title
                        }
                        if (!newimageEntered.isEmpty){
                            self.asset.image_link = newimageEntered
                        }
                        else{
                            self.asset.image_link = self.asset.image_link
                        }
                        if (!newlinkEntered.isEmpty){
                            self.asset.link = newlinkEntered
                        }
                        else{
                            self.asset.link = self.asset.link
                        }
                        if (!newchapterEntered.isEmpty){
                            self.asset.chapter = newchapterEntered
                        }
                        else{
                            self.asset.chapter = self.asset.chapter
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
struct BottomBar: View{
    @State var showAddScreen = false
    @State var showFavScreen = false
    @State var showListScreen = true
    @State var showHomeScreen = false
    @State var showUpdateScreen = false
    @State var showEditScreen = false
    var body: some View{
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

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: WebThings.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \WebThings.title, ascending: true)])

    var enities: FetchedResults<WebThings>
    var web = WebThings()
    
    @State var showAddScreen = false
    @State var showFavScreen = false
    @State var showListScreen = true
    @State var showHomeScreen = false
    @State var showUpdateScreen = false
    @State var showEditScreen = false
    @State var searchText = ""
    @State var action = ""
    @State var pressed = false
    @State var saveUpdate = false
    @State var showFavList = false
    @State var filterSelected = "all"
    @State var selectedAssetId: NSManagedObjectID?
    
    //@State private var enitityId: UUID
    @State var k=0;
    let placeholder = URL(string: "https://i.quotev.com/gcbuwion4kwa.jpg")
    
    var body: some View {
        if (showListScreen){
            //VStack{
            NavigationView {
                List{
                        SearchBar(text: $searchText)
                    ForEach(enities.filter({ searchText.isEmpty ? true : $0.title.contains(searchText) })) {WebThings in
                            if(filterSelected != "all"){
                                if(WebThings.type == filterSelected){
                                    let currentChapter = ChapterGetter(givenUrl: WebThings.link)
                                    let x = currentChapter.trimmingCharacters(in: .whitespacesAndNewlines)
                                    ZStack {
                                        Color.pink
                                        .cornerRadius(12)
                                    HStack {
                                        VStack{
                                            HStack{
                                                Image(systemName: "placeholder image")
                                                    .data(url: URL(string: "\(WebThings.image_link)") ?? placeholder!)
                                                    .resizable()
                                                    .frame(width: 125, height: 200)
                                                    .cornerRadius(12)
                                                VStack(alignment: .leading){
                                                    Text("\(WebThings.type)")
                                                        .font(.system(size: 15))
                                                        .fontWeight(.light)
    //                                                    .padding(.bottom, 15)
                                                    Text("\(WebThings.title)")
                                                        .font(.system(size: 25))
                                                        
                                                        .fixedSize(horizontal: false, vertical: true)
                                                        //.padding(.bottom, 55)
                                                    Spacer()
                                                    HStack{
                                                        Text("Chapter: \(WebThings.chapter)")
                                                            .font(.system(size: 20))
                                                        Link("Read",
                                                             destination: URL(string: "\(WebThings.link)") ?? placeholder!)
//                                                        Image(systemName: "circle.fill")
//                                                            .foregroundColor((WebThings.chapter.compare(x) == .orderedSame) ? .gray : .green)
                                                        FavoritesAdded(assetId:
                                                                        selectedAssetId ?? WebThings.objectID)
                                                            .environment(\.managedObjectContext, self.viewContext)
                                                        
                                                    }
                                                }
                                            }
                                        }
                                        if #available(iOS 15.0, *) {
                                            Spacer()
                                            
                                                .swipeActions(edge: .leading, content: {
                                                    Button(action: {
                                                        showEditScreen = true
                                                        self.selectedAssetId = WebThings.objectID
                                                        
                                                    }, label: {
                                                        Image(systemName: "square.and.pencil")
                                                            .font(.largeTitle)
                                                        //.imageScale(.large)
                                                    })
                                                        .tint(.blue)
                                                })
                                                .swipeActions(edge: .trailing) {
                                                                Button(role: .destructive) {
                                                                    //action
                                                                    viewContext.delete(WebThings)
                                                                    do {
                                                                        try viewContext.save()
                                                                    } catch {
                                                                        print(error.localizedDescription)
                                                                    }
                                                                } label: {
                                                                    Label("Delete", systemImage: "trash")
                                                                }
                                                }
                                        } else {
                                            // Fallback on earlier versions
                                            VStack{
                                               Button(action: {
                                                   showEditScreen = true
                                                   self.selectedAssetId = WebThings.objectID
   
                                               }, label: {
                                                   Image(systemName: "square.and.pencil")
                                                       .font(.largeTitle)
                                                   //.imageScale(.large)
                                               })
                                                   .buttonStyle(BorderlessButtonStyle())
                                            }
                                        }
                                        
                                    }
                                    .padding()
                                    HStack{
                                        VStack{
                                            ZStack{
                                            Image(systemName: "circle.fill")
                                                .foregroundColor((WebThings.chapter.compare(x) == .orderedSame) ? .clear : .green)
                                                .font(.largeTitle)
                                                Text("UP")
                                                    .foregroundColor((WebThings.chapter.compare(x) == .orderedSame) ? .clear : .white)
                                            }
                                            Spacer()
                                        }
                                            Spacer()
                                    }
                                    }
                                    .fixedSize(horizontal: false, vertical: true)
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                                    .sheet(isPresented: $showEditScreen) {
                                        EditScreenInCode(assetId:
                                                            selectedAssetId ?? WebThings.objectID)
                                            .environment(\.managedObjectContext, self.viewContext)
                                    }
                                }
                            }
                            else{
                                let currentChapter = ChapterGetter(givenUrl: WebThings.link)
                                let x = currentChapter.trimmingCharacters(in: .whitespacesAndNewlines)
                                ZStack {
                                    Color.pink
                                    .cornerRadius(12)
                                HStack {
                                    VStack{
                                        HStack{
                                            Image(systemName: "placeholder image")
                                                .data(url: URL(string: "\(WebThings.image_link)") ?? placeholder!)
                                                .resizable()
                                                .frame(width: 125, height: 200)
                                                .cornerRadius(12)
                                            VStack(alignment: .leading){
                                                HStack{
                                                    Text("\(WebThings.type)")
                                                        .font(.system(size: 15))
                                                        .fontWeight(.light)
    //                                                    .padding(.bottom, 15)
                                                    
//Menu for edit and favorites
                                                    
//                                                    Menu("Options") {
//                                                        Button("Edit", action: {
//                                                            showEditScreen = true
//                                                            self.selectedAssetId = WebThings.objectID
//                                                        })
//                                                       Button("Favorite", action: {
//                                                           if !(WebThings.favorite){
//                                                               WebThings.favorite = true
//                                                               showFavScreen = true
//
//                                                           }
//                                                           else{
//                                                               WebThings.favorite = false
//                                                               showFavScreen = false
//                                                           }
//                                                           do{
//                                                               try viewContext.save()
//                                                           }
//                                                           catch {
//                                                               print(error.localizedDescription)
//                                                           }
//                                                       })
//                                                    }
                                                }
                                                Text("\(WebThings.title)")
                                                    .font(.system(size: 25))
                                                    
                                                    .fixedSize(horizontal: false, vertical: true)
                                                    //.padding(.bottom, 55)
                                                Spacer()
                                                HStack{
                                                    Text("Chapter: \(WebThings.chapter)")
                                                        .font(.system(size: 20))
                                                    Link("Read",
                                                         destination: URL(string: "\(WebThings.link)") ?? placeholder!)
//                                                    Image(systemName: "circle.fill")
//                                                        .foregroundColor((WebThings.chapter.compare(x) == .orderedSame) ? .gray : .green)
                                                    FavoritesAdded(assetId:
                                                                    selectedAssetId ?? WebThings.objectID)
                                                        .environment(\.managedObjectContext, self.viewContext)
                                                }
                                            }
                                        }
                                    }
                                    if #available(iOS 15.0, *) {
                                        Spacer()
                                        
                                            .swipeActions(edge: .leading, content: {
                                                Button(action: {
                                                    showEditScreen = true
                                                    self.selectedAssetId = WebThings.objectID
                                                    //print("chapter")
                                                    print(currentChapter)
                                                }, label: {
                                                    Image(systemName: "square.and.pencil")
                                                        .font(.largeTitle)
                                                    //.imageScale(.large)
                                                })
                                                    .tint(.blue)
                                            })
                                            .swipeActions(edge: .trailing) {
                                                            Button(role: .destructive) {
                                                                //action
                                                                viewContext.delete(WebThings)
                                                                do {
                                                                    try viewContext.save()
                                                                } catch {
                                                                    print(error.localizedDescription)
                                                                }
                                                            } label: {
                                                                Label("Delete", systemImage: "trash")
                                                            }
                                            }
                                    } else {
                                        // Fallback on earlier versions
                                        VStack{
                                           Button(action: {
                                               showEditScreen = true
                                               self.selectedAssetId = WebThings.objectID

                                           }, label: {
                                               Image(systemName: "square.and.pencil")
                                                   .font(.largeTitle)
                                               //.imageScale(.large)
                                           })
                                               .buttonStyle(BorderlessButtonStyle())
                                        }
                                    }
                                    //VStack{
//                                        Button(action: {
//                                            showEditScreen = true
//                                            self.selectedAssetId = WebThings.objectID
//
//                                        }, label: {
//                                            Image(systemName: "square.and.pencil")
//                                                .font(.largeTitle)
//                                            //.imageScale(.large)
//                                        })
                                           // .buttonStyle(BorderlessButtonStyle())
//                                        FavoritesAdded(assetId:
//                                                        selectedAssetId ?? WebThings.objectID)
//                                            .environment(\.managedObjectContext, self.viewContext)
                                    //}
                                    
                                }
                                .padding()
                                    HStack{
                                    VStack{
                                        ZStack{
                                        Image(systemName: "circle.fill")
                                            .foregroundColor((WebThings.chapter.compare(x) == .orderedSame) ? .clear : .green)
                                            .font(.largeTitle)
                                            Text("UP")
                                                .foregroundColor((WebThings.chapter.compare(x) == .orderedSame) ? .clear : .white)
                                        }
                                        Spacer()
                                    }
                                        Spacer()
                                    }
                                }
                                .fixedSize(horizontal: false, vertical: true)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                                .sheet(isPresented: $showEditScreen) {
                                    EditScreenInCode(assetId:
                                                        selectedAssetId ?? WebThings.objectID)
                                        .environment(\.managedObjectContext, self.viewContext)
                                }
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
                    .listStyle(PlainListStyle())
                    .navigationTitle("List")
                    .navigationBarItems(trailing:
                                            Menu {
                        Button("All", action: allSelected)
                        Button("Webtoons", action: wtSelected)
                        Button("WebNovels", action: wnSelected)
                        Button("Manga", action: mSelected)
                    } label:{
                        Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                        //.font(.largeTitle)
                    }
                                        
                    )
                }
            //}
        }
        
    }
        func allSelected() {
            filterSelected = "all"
        }
        func wtSelected() {
            filterSelected = "Webtoon"
        }
        func wnSelected() {
            filterSelected = "Webnovel"
        }
        func mSelected() {
            filterSelected = "Manga"
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
struct PressActions: ViewModifier {
    var onPress: () -> Void
    var onRelease: () -> Void
    
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ _ in
                        onPress()
                    })
                    .onEnded({ _ in
                        onRelease()
                    })
            )
    }
}
extension View {
    func pressAction(onPress: @escaping (() -> Void), onRelease: @escaping (() -> Void)) -> some View {
        modifier(PressActions(onPress: {
            onPress()
        }, onRelease: {
            onRelease()
        }))
    }
}

import SwiftUI
import CoreData


struct FavScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: WebThings.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \WebThings.title, ascending: true)])

    var enities: FetchedResults<WebThings>
    var web = WebThings()
    
    @State var showAddScreen = false
    @State var showFavScreen = true
    @State var showListScreen = false
    @State var showHomeScreen = false
    @State var showUpdateScreen = false
    @State var showEditScreen = false
    @State var searchText = ""
    @State var pressed = false
    @State var showFavList = false
    @State var selectedAssetId: NSManagedObjectID?
    @State var k=0;
    let placeholder = URL(string: "https://i.quotev.com/gcbuwion4kwa.jpg")
    var body: some View {
        if (showFavScreen){
                //VStack{
                NavigationView {
                    List{
                        SearchBar(text: $searchText)
                        ForEach(enities.filter({ searchText.isEmpty ? true : $0.title.contains(searchText) })) {WebThings in
                            if(WebThings.favorite){
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
                        .navigationTitle("Favorites")
                        }
                //}
            }
            
        }
    }
   
struct FavScreen_Previews: PreviewProvider {
    static var previews: some View {
        FavScreen().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

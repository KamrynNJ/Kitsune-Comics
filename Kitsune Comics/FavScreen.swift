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
    var body: some View {
        if (showFavScreen){
                VStack{
                NavigationView {
                    List{
                        SearchBar(text: $searchText)
                        ForEach(enities.filter({ searchText.isEmpty ? true : $0.title.contains(searchText) })) {WebThings in
                            if(WebThings.favorite){
                                let currentChapter = ChapterGetter(givenUrl: WebThings.link)
                                let x = currentChapter.trimmingCharacters(in: .whitespacesAndNewlines)
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
                                                Image(systemName: "circle.fill")
                                                    .foregroundColor((WebThings.chapter.compare(x) == .orderedSame) ? .gray : .green)
                                            }
                                        }
                                    }
                                   }
                                   Spacer()
                                VStack{
                                Button(action: {
                                    showEditScreen = true
                                    self.selectedAssetId = WebThings.objectID
                                    //guard let image = self.selectedAssetId
    
                                }, label: {
                                    Image(systemName: "square.and.pencil")
                                        .font(.largeTitle)
                                        //.imageScale(.large)
                                })
                                .buttonStyle(BorderlessButtonStyle())
                                FavoritesAdded(assetId:
                                                selectedAssetId ?? WebThings.objectID)
                               .environment(\.managedObjectContext, self.viewContext)
                                }
                                
                               }
                               .frame(height: 100)
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
                        .navigationTitle("Favorites")
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
            else if(showListScreen){
                ContentView()
            }
            
        }
    }
   
struct FavScreen_Previews: PreviewProvider {
    static var previews: some View {
        FavScreen().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

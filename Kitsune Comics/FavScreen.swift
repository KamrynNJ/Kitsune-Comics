import SwiftUI

struct FavScreen: View {
    @State var showAddScreen = false
    @State var showFavScreen = true
    @State var showListScreen = false
    @State var showHomeScreen = false
    @State var showUpdateScreen = false
    var body: some View {
        if(showFavScreen){
            VStack{
            Text("Favorites")
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
        else if(showHomeScreen){
            HomeScreen()
        }
        else if(showAddScreen){
            AddEntryScreen()
        }
        else if (showUpdateScreen){
            UpdateScreen()
        }
        else if(showListScreen){
            ContentView()
        }
    }
   
}

struct FavScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}

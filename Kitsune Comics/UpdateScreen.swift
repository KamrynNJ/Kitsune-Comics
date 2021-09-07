import SwiftUI

struct UpdateScreen: View {
    @State var showAddScreen = false
    @State var showFavScreen = false
    @State var showListScreen = false
    @State var showHomeScreen = false
    @State var showUpdateScreen = true
    var body: some View {
        if(showUpdateScreen){
            VStack{
            Text("Updates")
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
        else if(showFavScreen){
            FavScreen()
        }
        else if(showAddScreen){
            AddEntryScreen()
        }
        else if (showHomeScreen){
            HomeScreen()
        }
        else if(showListScreen){
            ContentView()
        }
    }
   
}

struct UpdateScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}

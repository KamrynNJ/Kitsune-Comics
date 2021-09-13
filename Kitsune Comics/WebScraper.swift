//
//  WebScraper.swift
//  Kitsune Comics
//
//  Created by Kamryn Jones on 9/12/21.
//

import SwiftUI

func LinkGetter(givenUrl: String) -> String {
    if(givenUrl.range(of: "bato.to/rss", options: .caseInsensitive) != nil){
        let url = URL(string: givenUrl)
        let contents = try? String(contentsOf: url!)
        let linkBegin = contents?.distance(of: "https://bato.to/series") ?? 0
        let linkEnd = contents?.distance(of: "</link>") ?? 0
        let linkRange = linkBegin..<linkEnd
        let linkGotten = (contents?[linkRange])!
        let linkFinal = String(linkGotten)
        return linkFinal
    }
    else{
        return ""
    }
}

func ChapterGetter(givenUrl: String) -> String {
    if(givenUrl.range(of: "bato.to/rss", options: .caseInsensitive) != nil){
        let url = URL(string: givenUrl)
        let contents = try? String(contentsOf: url!)
        let chapterBegin = contents?.distance(of: "<item>") ?? 0
        let chapter2find1 = contents?.index(contents!.startIndex, offsetBy: chapterBegin)
        let newHTMlbcofLink = contents?[chapter2find1!..<contents!.endIndex]
        
        let chapterBegin2 = newHTMlbcofLink?.distance(of: "<title>") ?? 0
        let chapter2find2 = newHTMlbcofLink?.index(newHTMlbcofLink!.startIndex, offsetBy: chapterBegin2)
        let newHTMlbcofLink2 = newHTMlbcofLink?[chapter2find2!..<newHTMlbcofLink!.endIndex]
        
        let chapterBegin3 = newHTMlbcofLink2?.distance(of: "</title>") ?? 0
        let chapter2find3 = newHTMlbcofLink2?.index(newHTMlbcofLink2!.startIndex, offsetBy: chapterBegin3)
        let newHTMlbcofLink3 = newHTMlbcofLink2?[chapter2find3!..<newHTMlbcofLink2!.endIndex]
        
        let chapterBegin5 = newHTMlbcofLink2?.distance(of: "Chapter") ?? 0
        let chapter2find5 = newHTMlbcofLink2?.index(newHTMlbcofLink2!.startIndex, offsetBy: chapterBegin5)
        let newHTMlbcofLink5 = newHTMlbcofLink2?[chapter2find5!..<newHTMlbcofLink2!.endIndex]
        
        let chapterBegin6 = newHTMlbcofLink5?.distance(of: " ") ?? 0
        let chapter2find6 = newHTMlbcofLink5?.index(newHTMlbcofLink5!.startIndex, offsetBy: chapterBegin6)
        let newHTMlbcofLink6 = newHTMlbcofLink5?[chapter2find6!..<newHTMlbcofLink5!.endIndex]
        
        let newHTMlbcofLink4 = newHTMlbcofLink2?[chapter2find6!..<chapter2find3!]
        
        let y = newHTMlbcofLink4!.suffix(10)
        let chapterFinal = String(y)
        return chapterFinal
    }
    else{
        return ""
    }
}

func TitleGetter(givenUrl: String) -> String{
    if(givenUrl.range(of: "bato.to/rss", options: .caseInsensitive) != nil){
        let url = URL(string: givenUrl)
        let contents = try? String(contentsOf: url!)
        let titleBegin = contents?.distance(of: "<item>") ?? 0
        let title2find1 = contents?.index(contents!.startIndex, offsetBy: titleBegin)
        let titlenewHTMlbcofLink = contents?[title2find1!..<contents!.endIndex]
        
        let titleBegin2 = titlenewHTMlbcofLink?.distance(of: "<title>") ?? 0
        let title2find2 = titlenewHTMlbcofLink?.index(titlenewHTMlbcofLink!.startIndex, offsetBy: titleBegin2+7)
        let titlenewHTMlbcofLink2 = titlenewHTMlbcofLink?[title2find2!..<titlenewHTMlbcofLink!.endIndex]
        
        let titleBegin3 = titlenewHTMlbcofLink2?.distance(of: "</title>") ?? 0
        let title2find3 = titlenewHTMlbcofLink2?.index(titlenewHTMlbcofLink2!.startIndex, offsetBy: titleBegin3)
        let titlenewHTMlbcofLink3 = titlenewHTMlbcofLink2?[title2find3!..<titlenewHTMlbcofLink2!.endIndex]
        
        let titleBegin5 = titlenewHTMlbcofLink2?.distance(of: "Chapter") ?? 0
        let title2find5 = titlenewHTMlbcofLink2?.index(titlenewHTMlbcofLink2!.startIndex, offsetBy: titleBegin5)
        let titlenewHTMlbcofLink5 = titlenewHTMlbcofLink2?[title2find5!..<titlenewHTMlbcofLink2!.endIndex]
        
        let titleBegin6 = titlenewHTMlbcofLink5?.distance(of: " ") ?? 0
        let title2find6 = titlenewHTMlbcofLink5?.index(titlenewHTMlbcofLink5!.startIndex, offsetBy: titleBegin6)
        let titlenewHTMlbcofLink6 = titlenewHTMlbcofLink5?[title2find6!..<titlenewHTMlbcofLink5!.endIndex]
        
        let titlenewHTMlbcofLink4 = titlenewHTMlbcofLink2?[title2find2!..<title2find5!]
        
        let z = titlenewHTMlbcofLink4!.prefix(100)
        let titleFinal = String(z)
        return titleFinal
    }
    else{
        return ""
    }
}

func ImageGetter(givenUrl: String) -> String{
    if(givenUrl.range(of: "bato.to/rss", options: .caseInsensitive) != nil){
        let url = URL(string: givenUrl)
        let contents = try? String(contentsOf: url!)
        let imagelinkBegin = contents?.distance(of: "https://xfs-000") ?? 0
        let imagelinkEnd = contents?.distance(of: "</url>") ?? 0
        let imagelinkRange = imagelinkBegin..<imagelinkEnd
        let imagelinkGotten = (contents?[imagelinkRange])!
        let imagelinkFinal = String(imagelinkGotten)
        return imagelinkFinal
    }
    else{
        return ""
    }
}

func TypeGetter(givenUrl: String) -> String{
    if(givenUrl.range(of: "bato.to/rss", options: .caseInsensitive) != nil){
        let type = "Webtoon"
        return type
    }
    else{
        return ""
    }
}

struct WebScraper: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment (\.presentationMode) var presentationMode
    
    let entryTypes = ["Webtoon", "Webnovel", "Manga"]
    
    @State var selectedTypeIndex = 0
    @State var urlGiven: String
    @State var showHomeScreen = false
    var otherAddScreening = OtherAddScreen()
    
    var body: some View {
        let linkFinal = LinkGetter(givenUrl: urlGiven)
        let chapterFinal = ChapterGetter(givenUrl: urlGiven)
        let titleFinal = TitleGetter(givenUrl: urlGiven)
        let imagelinkFinal = ImageGetter(givenUrl: urlGiven)
        let typeFinal = TypeGetter(givenUrl: urlGiven)
       
            HStack {
                VStack(alignment: .leading) {
                 HStack{
                     Image(systemName: "placeholder image")
                     .data(url: URL(string: "\(imagelinkFinal)")!)
                        .frame(width:140, height: 200)
                     VStack{
                        Text("\(titleFinal)")
                         HStack{
                             Text("Chapter: \(chapterFinal)")
                             Link("Read",
                                   destination: URL(string: "\(linkFinal)")!)
                         }
                     }
                 }
                }
            }
        
            Button(action: {
                let newEntry = WebThings(context: viewContext)
                newEntry.type = typeFinal
                newEntry.title = titleFinal
                newEntry.image_link = imagelinkFinal
                newEntry.link = linkFinal
                newEntry.chapter = chapterFinal
                newEntry.id = UUID()
                do {
                    try viewContext.save()
                    showHomeScreen = true
                } catch {
                    print(error.localizedDescription)
                }
            }) {
                Text("Add Entry")
            }
            .buttonStyle(BorderlessButtonStyle())
    }
    
}

struct WebScraper_Previews: PreviewProvider {
    static var previews: some View {
        WebScraper(urlGiven: "https://bato.to/rss/series/80581.xml")
    }
}
extension Collection {
    func distance(to index: Index) -> Int { distance(from: startIndex, to: index) }
}
extension String.Index {
    func distance<S: StringProtocol>(in string: S) -> Int { string.distance(to: self) }
}
extension StringProtocol {
    func distance(of element: Element) -> Int? { firstIndex(of: element)?.distance(in: self) }
    func distance<S: StringProtocol>(of string: S) -> Int? { range(of: string)?.lowerBound.distance(in: self) }
}
extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }

    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
         return String(self[start...])
    }
}

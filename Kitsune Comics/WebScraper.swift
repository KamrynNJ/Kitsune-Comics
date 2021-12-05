//
//  WebScraper.swift
//  Kitsune Comics
//
//  Created by Kamryn Jones on 9/12/21.
//

import SwiftUI
import Foundation
import SwiftSoup

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
    else if(givenUrl.range(of: "https://zinmanga.com/", options: .caseInsensitive) != nil){
        let url = URL(string: givenUrl)!
        let html = (try? String(contentsOf: url, encoding: String.Encoding.ascii))
        return givenUrl
    }
    else if(givenUrl.range(of: "https://1stkissmanga.love/", options: .caseInsensitive) != nil || givenUrl.range(of: "https://1stkissmanga.io/", options: .caseInsensitive) != nil){
        let url = URL(string: givenUrl)!
        let html = (try? String(contentsOf: url, encoding: String.Encoding.ascii))
        return givenUrl
    }
    else if(givenUrl.range(of: "batotoo.com/rss", options: .caseInsensitive) != nil){
        let url = URL(string: givenUrl)
        let contents = try? String(contentsOf: url!)
        let linkBegin = contents?.distance(of: "https://batotoo.com/series") ?? 0
        let linkEnd = contents?.distance(of: "</link>") ?? 0
        let linkRange = linkBegin..<linkEnd
        let linkGotten = (contents?[linkRange])!
        let linkFinal = String(linkGotten)
        return linkFinal
    }
    else if(givenUrl.range(of: "https://www.lightnovelpub.com/", options: .caseInsensitive) != nil){
        return givenUrl
    }
    else if(givenUrl.range(of: "https://www.mtlnovel.com/", options: .caseInsensitive) != nil){
        return givenUrl
    }
    else{
        return ""
    }
}

func ChapterGetter(givenUrl: String) -> String {
    if(givenUrl.range(of: "bato.to/rss", options: .caseInsensitive) != nil || givenUrl.range(of: "batotoo.com/rss", options: .caseInsensitive) != nil){
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
    else if(givenUrl.range(of: "https://zinmanga.com/", options: .caseInsensitive) != nil){
        let url = URL(string: givenUrl)!
        let html = (try? String(contentsOf: url, encoding: String.Encoding.ascii))
        
        let chapterBegin = html?.distance(of: "wp-manga-chapter") ?? 0
        let chapter2find1 = html?.index(html!.startIndex, offsetBy: chapterBegin)
        let newHTMlbcofLink = html?[chapter2find1!..<html!.endIndex]
        
        let chapterBegin2 = newHTMlbcofLink?.distance(of: "Chapter") ?? 0
        let chapter2find2 = newHTMlbcofLink?.index(newHTMlbcofLink!.startIndex, offsetBy: chapterBegin2)
        let newHTMlbcofLink2 = newHTMlbcofLink?[chapter2find2!..<newHTMlbcofLink!.endIndex]
        
        let chapterBegin3 = newHTMlbcofLink2?.distance(of: " ") ?? 0
        let chapter2find3 = newHTMlbcofLink2?.index(newHTMlbcofLink2!.startIndex, offsetBy: chapterBegin3)
        let newHTMlbcofLink3 = newHTMlbcofLink2?[chapter2find3!..<newHTMlbcofLink2!.endIndex]
        
        let chapterBegin4 = newHTMlbcofLink3?.distance(of: " </a>") ?? 0
        let chapter2find4 = newHTMlbcofLink3?.index(newHTMlbcofLink3!.startIndex, offsetBy: chapterBegin4)
        let newHTMlbcofLink4 = newHTMlbcofLink3?[chapter2find4!..<newHTMlbcofLink3!.endIndex]
        
        let titleSub = html![chapter2find3!..<chapter2find4!]
        let chapterFinal = String(titleSub)
        
        return chapterFinal
    }
    else if(givenUrl.range(of: "https://bato.to/series", options: .caseInsensitive) != nil){
        let url = URL(string: givenUrl)!
        let html = (try? String(contentsOf: url, encoding: String.Encoding.ascii))
        
        let chapterBegin = html?.distance(of: "visited chapt") ?? 0
        let chapter2find1 = html?.index(html!.startIndex, offsetBy: chapterBegin)
        let newHTMlbcofLink = html?[chapter2find1!..<html!.endIndex]
        
        let chapterBegin2 = newHTMlbcofLink?.distance(of: "<b>") ?? 0
        let chapter2find2 = newHTMlbcofLink?.index(newHTMlbcofLink!.startIndex, offsetBy: chapterBegin2)
        let newHTMlbcofLink2 = newHTMlbcofLink?[chapter2find2!..<newHTMlbcofLink!.endIndex]
        
        let chapterBegin3 = newHTMlbcofLink2?.distance(of: "Chapter") ?? 0
        let chapter2find3 = newHTMlbcofLink2?.index(newHTMlbcofLink2!.startIndex, offsetBy: chapterBegin3+8)
        let newHTMlbcofLink3 = newHTMlbcofLink2?[chapter2find3!..<newHTMlbcofLink2!.endIndex]
        
        let chapterBegin4 = newHTMlbcofLink3?.distance(of: "</b>") ?? 0
        let chapter2find4 = newHTMlbcofLink3?.index(newHTMlbcofLink3!.startIndex, offsetBy: chapterBegin4)
        let newHTMlbcofLink4 = newHTMlbcofLink3?[chapter2find4!..<newHTMlbcofLink3!.endIndex]
        
        let titleSub = html![chapter2find3!..<chapter2find4!]
        let chapterFinal = String(titleSub)
        
        return chapterFinal
    }
    else if(givenUrl.range(of: "1stkissmanga.love", options: .caseInsensitive) != nil || givenUrl.range(of: "https://1stkissmanga.io/", options: .caseInsensitive) != nil){
        let url = URL(string: givenUrl)!
        let html = (try? String(contentsOf: url, encoding: String.Encoding.ascii))
        
        let chapterBegin = html?.distance(of: "wp-manga-chapter") ?? 0
        let chapter2find1 = html?.index(html!.startIndex, offsetBy: chapterBegin)
        let newHTMlbcofLink = html?[chapter2find1!..<html!.endIndex]
        
        let chapterBegin2 = newHTMlbcofLink?.distance(of: "Chapter") ?? 0
        let chapter2find2 = newHTMlbcofLink?.index(newHTMlbcofLink!.startIndex, offsetBy: chapterBegin2)
        let newHTMlbcofLink2 = newHTMlbcofLink?[chapter2find2!..<newHTMlbcofLink!.endIndex]
        
        let chapterBegin3 = newHTMlbcofLink2?.distance(of: " ") ?? 0
        let chapter2find3 = newHTMlbcofLink2?.index(newHTMlbcofLink2!.startIndex, offsetBy: chapterBegin3)
        let newHTMlbcofLink3 = newHTMlbcofLink2?[chapter2find3!..<newHTMlbcofLink2!.endIndex]
        
        let chapterBegin4 = newHTMlbcofLink3?.distance(of: " </a>") ?? 0
        let chapter2find4 = newHTMlbcofLink3?.index(newHTMlbcofLink3!.startIndex, offsetBy: chapterBegin4)
        let newHTMlbcofLink4 = newHTMlbcofLink3?[chapter2find4!..<newHTMlbcofLink3!.endIndex]
        
        let titleSub = html![chapter2find3!..<chapter2find4!]
        let chapterFinal = String(titleSub)
        
        return chapterFinal
    }
    else if(givenUrl.range(of: "https://www.lightnovelpub.com/", options: .caseInsensitive) != nil){
        let url = URL(string: givenUrl)!
        let html = (try? String(contentsOf: url, encoding: String.Encoding.ascii))
        
        let chapterBegin = html?.distance(of: "icon-book-open\">") ?? 0
        let chapter2find1 = html?.index(html!.startIndex, offsetBy: chapterBegin+5)
        let newHTMlbcofLink = html?[chapter2find1!..<html!.endIndex]
        
        let chapterBegin2 = newHTMlbcofLink?.distance(of: "icon-book-open\">") ?? 0
        let chapter2find2 = newHTMlbcofLink?.index(newHTMlbcofLink!.startIndex, offsetBy: chapterBegin2)
        let newHTMlbcofLink2 = newHTMlbcofLink?[chapter2find2!..<newHTMlbcofLink!.endIndex]
        
        let chapterBegin3 = newHTMlbcofLink2?.distance(of: "</i> ") ?? 0
        let chapter2find3 = newHTMlbcofLink2?.index(newHTMlbcofLink2!.startIndex, offsetBy: chapterBegin3+5)
        let newHTMlbcofLink3 = newHTMlbcofLink2?[chapter2find3!..<newHTMlbcofLink2!.endIndex]
        
        let chapterBegin4 = newHTMlbcofLink3?.distance(of: "</strong") ?? 0
        let chapter2find4 = newHTMlbcofLink3?.index(newHTMlbcofLink3!.startIndex, offsetBy: chapterBegin4)
        let newHTMlbcofLink4 = newHTMlbcofLink3?[chapter2find4!..<newHTMlbcofLink3!.endIndex]
        
        let titleSub = html![chapter2find3!..<chapter2find4!]
        let chapterFinal = String(titleSub)
        
        return chapterFinal
    }
    else if(givenUrl.range(of: "https://www.mtlnovel.com/", options: .caseInsensitive) != nil){
        let url = URL(string: givenUrl)!
        let html = (try? String(contentsOf: url, encoding: String.Encoding.ascii))
        
        let chapterBegin = html?.distance(of: "info-wrap") ?? 0
        let chapter2find1 = html?.index(html!.startIndex, offsetBy: chapterBegin+5)
        let newHTMlbcofLink = html?[chapter2find1!..<html!.endIndex]
        
        let chapterBegin2 = newHTMlbcofLink?.distance(of: "<small>") ?? 0
        let chapter2find2 = newHTMlbcofLink?.index(newHTMlbcofLink!.startIndex, offsetBy: chapterBegin2+2)
        let newHTMlbcofLink2 = newHTMlbcofLink?[chapter2find2!..<newHTMlbcofLink!.endIndex]
        
        let chapterBegin3 = newHTMlbcofLink2?.distance(of: "<div") ?? 0
        let chapter2find3 = newHTMlbcofLink2?.index(newHTMlbcofLink2!.startIndex, offsetBy: chapterBegin3+15)
        let newHTMlbcofLink3 = newHTMlbcofLink2?[chapter2find3!..<newHTMlbcofLink2!.endIndex]
        
        let chapterBegin4 = newHTMlbcofLink3?.distance(of: "<small>") ?? 0
        let chapter2find4 = newHTMlbcofLink3?.index(newHTMlbcofLink3!.startIndex, offsetBy: chapterBegin4)
        let newHTMlbcofLink4 = newHTMlbcofLink3?[chapter2find4!..<newHTMlbcofLink3!.endIndex]
        
        let titleSub = html![chapter2find3!..<chapter2find4!]
        let chapterFinal = String(titleSub)
        
        return chapterFinal
    }
    else if(givenUrl.range(of: "https://daonovel.com/", options: .caseInsensitive) != nil){
        let url = URL(string: givenUrl)!
        let html = (try? String(contentsOf: url, encoding: String.Encoding.ascii))
        
        let chapterBegin = html?.distance(of: "::before") ?? 0
        let chapter2find1 = html?.index(html!.startIndex, offsetBy: chapterBegin+5)
        let newHTMlbcofLink = html?[chapter2find1!..<html!.endIndex]
        
        let chapterBegin2 = newHTMlbcofLink?.distance(of: "<small>") ?? 0
        let chapter2find2 = newHTMlbcofLink?.index(newHTMlbcofLink!.startIndex, offsetBy: chapterBegin2+2)
        let newHTMlbcofLink2 = newHTMlbcofLink?[chapter2find2!..<newHTMlbcofLink!.endIndex]
        
        let chapterBegin3 = newHTMlbcofLink2?.distance(of: "<div") ?? 0
        let chapter2find3 = newHTMlbcofLink2?.index(newHTMlbcofLink2!.startIndex, offsetBy: chapterBegin3+15)
        let newHTMlbcofLink3 = newHTMlbcofLink2?[chapter2find3!..<newHTMlbcofLink2!.endIndex]
        
        let chapterBegin4 = newHTMlbcofLink3?.distance(of: "<small>") ?? 0
        let chapter2find4 = newHTMlbcofLink3?.index(newHTMlbcofLink3!.startIndex, offsetBy: chapterBegin4)
        let newHTMlbcofLink4 = newHTMlbcofLink3?[chapter2find4!..<newHTMlbcofLink3!.endIndex]
        
        let titleSub = html![chapter2find3!..<chapter2find4!]
        let chapterFinal = String(titleSub)
        
        return chapterFinal
    }
    else{
        return ""
    }
}

func TitleGetter(givenUrl: String) -> String{
    if(givenUrl.range(of: "bato.to/rss", options: .caseInsensitive) != nil || givenUrl.range(of: "batotoo.com/rss", options: .caseInsensitive) != nil){
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
    else if(givenUrl.range(of: "https://zinmanga.com/", options: .caseInsensitive) != nil){
        let url = URL(string: givenUrl)!
        let html = (try? String(contentsOf: url, encoding: String.Encoding.ascii))
        let doc: Document = try! SwiftSoup.parse(html!)
        let docTitle = try! doc.title()
        
        let titleBegin = html?.distance(of: "post-title") ?? 0
        let title2find1 = html?.index(html!.startIndex, offsetBy: titleBegin)
        let titlenewHTMlbcofLink = html?[title2find1!..<html!.endIndex]
        
        let titleBegin2 = titlenewHTMlbcofLink?.distance(of: "<h1>") ?? 0
        let title2find2 = titlenewHTMlbcofLink?.index(titlenewHTMlbcofLink!.startIndex, offsetBy: titleBegin2+5)
        let titlenewHTMlbcofLink2 = titlenewHTMlbcofLink?[title2find2!..<titlenewHTMlbcofLink!.endIndex]
        
        let titleBegin3 = titlenewHTMlbcofLink2?.distance(of: "</h1>") ?? 0
        let title2find3 = titlenewHTMlbcofLink2?.index(titlenewHTMlbcofLink2!.startIndex, offsetBy: titleBegin3-1)
        let titlenewHTMlbcofLink3 = titlenewHTMlbcofLink2?[title2find3!..<titlenewHTMlbcofLink2!.endIndex]
        
        let titlenewHTMlbcofLink4 = titlenewHTMlbcofLink2?[title2find2!..<title2find3!]
        
        let z = titlenewHTMlbcofLink4!
        let titleFinal2 = String(z)
        return titleFinal2
        
    }
    else if(givenUrl.range(of: "https://1stkissmanga.love/", options: .caseInsensitive) != nil || givenUrl.range(of: "https://1stkissmanga.io/", options: .caseInsensitive) != nil){
        let url = URL(string: givenUrl)!
        let html = (try? String(contentsOf: url, encoding: String.Encoding.ascii))
        
        let titleBegin = html?.distance(of: "post-title") ?? 0
        let title2find1 = html?.index(html!.startIndex, offsetBy: titleBegin)
        let titlenewHTMlbcofLink = html?[title2find1!..<html!.endIndex]
        
        let titleBegin2 = titlenewHTMlbcofLink?.distance(of: "<h1>") ?? 0
        let title2find2 = titlenewHTMlbcofLink?.index(titlenewHTMlbcofLink!.startIndex, offsetBy: titleBegin2+5)
        let titlenewHTMlbcofLink2 = titlenewHTMlbcofLink?[title2find2!..<titlenewHTMlbcofLink!.endIndex]
        
        let titleBegin3 = titlenewHTMlbcofLink2?.distance(of: "</h1>") ?? 0
        let title2find3 = titlenewHTMlbcofLink2?.index(titlenewHTMlbcofLink2!.startIndex, offsetBy: titleBegin3-1)
        let titlenewHTMlbcofLink3 = titlenewHTMlbcofLink2?[title2find3!..<titlenewHTMlbcofLink2!.endIndex]
        
        let titlenewHTMlbcofLink4 = titlenewHTMlbcofLink2?[title2find2!..<title2find3!]
        
        let z = titlenewHTMlbcofLink4!
        let titleFinal2 = String(z)
        return titleFinal2
    }
    else if (givenUrl.range(of: "https://www.lightnovelpub.com/", options: .caseInsensitive) != nil){
        let url = URL(string: givenUrl)!
        let html = (try? String(contentsOf: url, encoding: String.Encoding.ascii))
        
        let titleBegin = html?.distance(of: "novel-title text2row") ?? 0
        let title2find1 = html?.index(html!.startIndex, offsetBy: titleBegin+22)
        let titlenewHTMlbcofLink = html?[title2find1!..<html!.endIndex]
        
        let titleBegin2 = titlenewHTMlbcofLink?.distance(of: "</h1>") ?? 0
        let title2find2 = titlenewHTMlbcofLink?.index(titlenewHTMlbcofLink!.startIndex, offsetBy: titleBegin2)
        let titlenewHTMlbcofLink2 = titlenewHTMlbcofLink?[title2find2!..<titlenewHTMlbcofLink!.endIndex]
        
//        let titleBegin3 = titlenewHTMlbcofLink2?.distance(of: "</h1>") ?? 0
//        let title2find3 = titlenewHTMlbcofLink2?.index(titlenewHTMlbcofLink2!.startIndex, offsetBy: titleBegin3-1)
//        let titlenewHTMlbcofLink3 = titlenewHTMlbcofLink2?[title2find3!..<titlenewHTMlbcofLink2!.endIndex]
        
        let titlenewHTMlbcofLink4 = titlenewHTMlbcofLink?[title2find1!..<title2find2!]
        
        let z = titlenewHTMlbcofLink4!
        let titleFinal2 = String(z)
        return titleFinal2
    }
    else if(givenUrl.range(of: "https://www.mtlnovel.com/", options: .caseInsensitive) != nil){
        let url = URL(string: givenUrl)!
        let html = (try? String(contentsOf: url, encoding: String.Encoding.ascii))
        
        let titleBegin = html?.distance(of: "entry-title\">") ?? 0
        let title2find1 = html?.index(html!.startIndex, offsetBy: titleBegin+13)
        let titlenewHTMlbcofLink = html?[title2find1!..<html!.endIndex]
        
        let titleBegin2 = titlenewHTMlbcofLink?.distance(of: "</h1>") ?? 0
        let title2find2 = titlenewHTMlbcofLink?.index(titlenewHTMlbcofLink!.startIndex, offsetBy: titleBegin2)
        let titlenewHTMlbcofLink2 = titlenewHTMlbcofLink?[title2find2!..<titlenewHTMlbcofLink!.endIndex]
        
//        let titleBegin3 = titlenewHTMlbcofLink2?.distance(of: "</h1>") ?? 0
//        let title2find3 = titlenewHTMlbcofLink2?.index(titlenewHTMlbcofLink2!.startIndex, offsetBy: titleBegin3-1)
//        let titlenewHTMlbcofLink3 = titlenewHTMlbcofLink2?[title2find3!..<titlenewHTMlbcofLink2!.endIndex]
        
        let titlenewHTMlbcofLink4 = titlenewHTMlbcofLink?[title2find1!..<title2find2!]
        
        let z = titlenewHTMlbcofLink4!
        let titleFinal2 = String(z)
        return titleFinal2
    }
    else{
        return ""
    }
}

func ImageGetter(givenUrl: String) -> String{
    if(givenUrl.range(of: "bato.to/rss", options: .caseInsensitive) != nil || givenUrl.range(of: "batotoo.com/rss", options: .caseInsensitive) != nil){
        let url = URL(string: givenUrl)
        let contents = try? String(contentsOf: url!)
        let imagelinkBegin = contents?.distance(of: "https://xfs-000") ?? 0
        let imagelinkEnd = contents?.distance(of: "</url>") ?? 0
        let imagelinkRange = imagelinkBegin..<imagelinkEnd
        let imagelinkGotten = (contents?[imagelinkRange])!
        let imagelinkFinal = String(imagelinkGotten)
        return imagelinkFinal
    }
    else if(givenUrl.range(of: "https://zinmanga.com/", options: .caseInsensitive) != nil){
        let url = URL(string: givenUrl)!
        let html = (try? String(contentsOf: url, encoding: String.Encoding.ascii))
        
        let imgBegin = html?.distance(of: "summary_image") ?? 0
        let img2find1 = html?.index(html!.startIndex, offsetBy: imgBegin)
        let newHTMlbcofLink = html?[img2find1!..<html!.endIndex]
        
        let imgBegin2 = newHTMlbcofLink?.distance(of: "data-src=\"") ?? 0
        let img2find2 = newHTMlbcofLink?.index(newHTMlbcofLink!.startIndex, offsetBy: imgBegin2+10)
        let newHTMlbcofLink2 = newHTMlbcofLink?[img2find2!..<newHTMlbcofLink!.endIndex]
        
        let imgBegin3 = newHTMlbcofLink2?.distance(of: " ") ?? 0
        let img2find3 = newHTMlbcofLink2?.index(newHTMlbcofLink2!.startIndex, offsetBy: imgBegin3-1)
        let newHTMlbcofLink3 = newHTMlbcofLink2?[img2find3!..<newHTMlbcofLink2!.endIndex]
        
        let imgSub = html![img2find2!..<img2find3!]
        let imgFinal = String(imgSub)
        
        return imgFinal
    }
    else if(givenUrl.range(of: "https://1stkissmanga.love/", options: .caseInsensitive) != nil ){
        let url = URL(string: givenUrl)!
        let html = (try? String(contentsOf: url, encoding: String.Encoding.ascii))
        
        let imgBegin = html?.distance(of: "summary_image") ?? 0
        let img2find1 = html?.index(html!.startIndex, offsetBy: imgBegin)
        let newHTMlbcofLink = html?[img2find1!..<html!.endIndex]
        
        let imgBegin2 = newHTMlbcofLink?.distance(of: "srcset=\"") ?? 0
        let img2find2 = newHTMlbcofLink?.index(newHTMlbcofLink!.startIndex, offsetBy: imgBegin2+8)
        let newHTMlbcofLink2 = newHTMlbcofLink?[img2find2!..<newHTMlbcofLink!.endIndex]
        
        let imgBegin3 = newHTMlbcofLink2?.distance(of: " ") ?? 0
        let img2find3 = newHTMlbcofLink2?.index(newHTMlbcofLink2!.startIndex, offsetBy: imgBegin3)
        let newHTMlbcofLink3 = newHTMlbcofLink2?[img2find3!..<newHTMlbcofLink2!.endIndex]
        
        let imgSub = html![img2find2!..<img2find3!]
        let imgFinal = String(imgSub)
        
        return imgFinal
    }
    else if(givenUrl.range(of: "https://1stkissmanga.io/", options: .caseInsensitive) != nil){
        let url = URL(string: givenUrl)!
        let html = (try? String(contentsOf: url, encoding: String.Encoding.ascii))
        
        let imgBegin = html?.distance(of: "summary_image") ?? 0
        let img2find1 = html?.index(html!.startIndex, offsetBy: imgBegin)
        let newHTMlbcofLink = html?[img2find1!..<html!.endIndex]
        
        let imgBegin2 = newHTMlbcofLink?.distance(of: "data-lazy-src=\"") ?? 0
        let img2find2 = newHTMlbcofLink?.index(newHTMlbcofLink!.startIndex, offsetBy: imgBegin2+15)
        let newHTMlbcofLink2 = newHTMlbcofLink?[img2find2!..<newHTMlbcofLink!.endIndex]
        
        let imgBegin3 = newHTMlbcofLink2?.distance(of: " ") ?? 0
        let img2find3 = newHTMlbcofLink2?.index(newHTMlbcofLink2!.startIndex, offsetBy: imgBegin3-1)
        let newHTMlbcofLink3 = newHTMlbcofLink2?[img2find3!..<newHTMlbcofLink2!.endIndex]
        
        let imgSub = html![img2find2!..<img2find3!]
        let imgFinal = String(imgSub)
        
        return imgFinal
    }
    else if(givenUrl.range(of: "https://www.lightnovelpub.com/", options: .caseInsensitive) != nil){
        let url = URL(string: givenUrl)!
        let html = (try? String(contentsOf: url, encoding: String.Encoding.ascii))
        
        let imgBegin = html?.distance(of: "<figure class=\"cover\">") ?? 0
        let img2find1 = html?.index(html!.startIndex, offsetBy: imgBegin)
        let newHTMlbcofLink = html?[img2find1!..<html!.endIndex]
        
        let imgBegin2 = newHTMlbcofLink?.distance(of: "data-src=\"") ?? 0
        let img2find2 = newHTMlbcofLink?.index(newHTMlbcofLink!.startIndex, offsetBy: imgBegin2+10)
        let newHTMlbcofLink2 = newHTMlbcofLink?[img2find2!..<newHTMlbcofLink!.endIndex]
        
        let imgBegin3 = newHTMlbcofLink2?.distance(of: "alt") ?? 0
        let img2find3 = newHTMlbcofLink2?.index(newHTMlbcofLink2!.startIndex, offsetBy: imgBegin3-2)
        let newHTMlbcofLink3 = newHTMlbcofLink2?[img2find3!..<newHTMlbcofLink2!.endIndex]
        
        let imgSub = html![img2find2!..<img2find3!]
        let imgFinal = String(imgSub)
        
        return imgFinal
    }
    else if(givenUrl.range(of: "https://www.mtlnovel.com/", options: .caseInsensitive) != nil){
        let url = URL(string: givenUrl)!
        let html = (try? String(contentsOf: url, encoding: String.Encoding.ascii))
        
        let imgBegin = html?.distance(of: "</amp-img>") ?? 0
        let img2find1 = html?.index(html!.startIndex, offsetBy: imgBegin+20)
        let newHTMlbcofLink = html?[img2find1!..<html!.endIndex]
        
        let imgBegin2 = newHTMlbcofLink?.distance(of: "<amp-img") ?? 0
        let img2find2 = newHTMlbcofLink?.index(newHTMlbcofLink!.startIndex, offsetBy: imgBegin2)
        let newHTMlbcofLink2 = newHTMlbcofLink?[img2find2!..<newHTMlbcofLink!.endIndex]
        
        let imgBegin3 = newHTMlbcofLink2?.distance(of: "src=\"") ?? 0
        let img2find3 = newHTMlbcofLink2?.index(newHTMlbcofLink2!.startIndex, offsetBy: imgBegin3+5)
        let newHTMlbcofLink3 = newHTMlbcofLink2?[img2find3!..<newHTMlbcofLink2!.endIndex]
        
        let imgBegin4 = newHTMlbcofLink3?.distance(of: "alt") ?? 0
        let img2find4 = newHTMlbcofLink3?.index(newHTMlbcofLink3!.startIndex, offsetBy: imgBegin4-2)
        let newHTMlbcofLink4 = newHTMlbcofLink3?[img2find4!..<newHTMlbcofLink3!.endIndex]
        
        let imgSub = html![img2find3!..<img2find4!]
        let imgFinal = String(imgSub)
        
        return imgFinal
    }
    else{
        return ""
    }
}

func TypeGetter(givenUrl: String) -> String{
    if(givenUrl.range(of: "bato.to/rss", options: .caseInsensitive) != nil || givenUrl.range(of: "batotoo.com/rss", options: .caseInsensitive) != nil){
        let type = "Webtoon"
        return type
    }
    else if(givenUrl.range(of: "https://zinmanga.com/", options: .caseInsensitive) != nil){
        let type = "Webtoon"
        return type
    }
    else if(givenUrl.range(of: "1stkissmanga.love/", options: .caseInsensitive) != nil || givenUrl.range(of: "https://1stkissmanga.io/", options: .caseInsensitive) != nil){
        let type = "Webtoon"
        return type
    }
    else if(givenUrl.range(of: "https://www.lightnovelpub.com/", options: .caseInsensitive) != nil){
        let type = "Webnovel"
        return type
    }
    else if(givenUrl.range(of: "https://www.mtlnovel.com/", options: .caseInsensitive) != nil){
        let type = "Webnovel"
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
    @State var urlGiven = ""
    @State var showHomeScreen = false
    @State private var showingAlert = false
    var otherAddScreening = OtherAddScreen()
    @State var numberOfSlices = 1
    @State var titleEntered = ""
    @State var imageEntered = ""
    @State var linkEntered = ""
    @State var chapterEntered = ""
    @State var x = ""
    @State var showAddScreen = true
    @State var showFavScreen = false
    @State var showListScreen = false
    @State var showUpdateScreen = false
    @State private var showOtherAddScreen = true
    @State private var showEasyAddScren = false
    @State private var hideVisited = false
    @State private var doIWantThisViewToShow = false
    
    var body: some View {
//        let linkFinal = LinkGetter(givenUrl: linkEntered)
//        let chapterFinal = ChapterGetter(givenUrl: linkEntered)
//        let titleFinal = TitleGetter(givenUrl: linkEntered)
//        let imagelinkFinal = ImageGetter(givenUrl: linkEntered)
//        let typeFinal = TypeGetter(givenUrl: linkEntered)
        //Text (chapterFinal)
            VStack{
            NavigationView {
                Form {
                    Section(header: Text("Link")) {
                        TextField("Entry Link", text: $linkEntered)
                    }
                    Section(header: Text("preview")){
                        VStack {
                                    Button("Preview Entry") {
                                        doIWantThisViewToShow.toggle()
                                    }
                        if doIWantThisViewToShow {
                            let linkFinal = LinkGetter(givenUrl: linkEntered)
                            let chapterFinal = ChapterGetter(givenUrl: linkEntered)
                            let titleFinal = TitleGetter(givenUrl: linkEntered)
                            let imagelinkFinal = ImageGetter(givenUrl: linkEntered)
                            let typeFinal = TypeGetter(givenUrl: linkEntered)
                            let placeholder = URL(string: "https://i.quotev.com/gcbuwion4kwa.jpg")
                            
                            HStack {
                                VStack(alignment: .leading) {
                                 HStack{
                                     Image(systemName: "placeholder image")
                                         .data(url: (URL(string: "\(imagelinkFinal)")) ?? placeholder!)
                                        .frame(width:140, height: 200)
                                     VStack{
                                        Text("\(titleFinal)")
                                         HStack{
                                             Text("Chapter: \(chapterFinal)")
                                             //Text("Link: \(linkFinal)")
                                             Link("Read",
                                                  destination: URL(string: "\(linkFinal)") ?? placeholder!)
                                         }
                                     }
                                 }
                                }
                            }
                            .alert(isPresented: $showingAlert) {
                                            Alert(
                                                title: Text("Entry Added")
                                            )
                                        }

                            Button(action: {
                                showingAlert = true

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
                        
                    }
                }
                .navigationBarTitle(" Better Add Entry")
            }//end of hs
                
                }
        
            }
        }


struct WebScraper_Previews: PreviewProvider {
    static var previews: some View {
        WebScraper()
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

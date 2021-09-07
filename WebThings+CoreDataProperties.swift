//
//  WebThings+CoreDataProperties.swift
//  Kitsune Comics
//
//  Created by Kamryn Jones on 9/5/21.
//
//

import Foundation
import CoreData


extension WebThings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WebThings> {
        return NSFetchRequest<WebThings>(entityName: "WebThings")
    }

    @NSManaged public var chapter: String
    @NSManaged public var id: UUID?
    @NSManaged public var image_link: String
    @NSManaged public var link: String
    @NSManaged public var title: String
    @NSManaged public var type: String
}
    
    
//    var formatType: Typing {
//        set {
//            type = newValue.rawValue
//        }
//        get {
//            Typing(rawValue: type) ?? .webtoon
//        }
//    }
//
//}

extension WebThings : Identifiable {

}
//enum Typing: String {
//    case webtoon = "Webtoon"
//    case webnovel = "Webnovel"
//    case manga = "Manga"
//}

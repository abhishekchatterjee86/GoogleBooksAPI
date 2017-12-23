import Foundation

public protocol Deserializable {
    static func create(_ dict: [AnyHashable:Any]) -> Self?
}

extension Books: Deserializable {
    
    public static func create(_ dict: [AnyHashable:Any]) -> Books? {
        guard
            let items = dict["items"] as? [[AnyHashable:Any]]
            else { return nil }
        return Books(totalItems: dict["totalItems"] as? Int,items: items.flatMap(Book.create))
    }
}

extension Book: Deserializable {
    
    public static func create(_ dict: [AnyHashable:Any]) -> Book? {
        guard
            let id = dict["id"] as? String,
            let volumeInfoDict = dict["volumeInfo"] as? [AnyHashable:Any]
            else { return nil }

        guard
            let volumeInfo = BookInfo.create(volumeInfoDict)
            else { return nil }
        return Book(id: Id(id), volumeInfo: volumeInfo)
    }
}

extension Book.BookInfo {
    
    static func create(_ dict: [AnyHashable:Any]) -> Book.BookInfo? {
        guard
            let title = dict["title"] as? String
            else { return nil }
        let subtitle = dict["subtitle"] as? String
        let authors = dict["authors"] as? [String]
        let publisher = dict["publisher"] as? String
        let publishedDate = dict["publishedDate"] as? String
        let desc = dict["description"] as? String
        let pageCount = dict["pageCount"] as? Int
        let mainCategory = dict["mainCategory"] as? String
        let language = dict["language"] as? String
        let imageLinks = (dict["imageLinks"] as? [AnyHashable:Any]).flatMap(Book.BookInfo.ImageLinks.create)
        return Book.BookInfo(
            title: title,
            subtitle: subtitle,
            authors: authors ?? [],
            publisher: publisher,
            publishedDate: publishedDate,
            desc: desc,
            pageCount: pageCount,
            mainCategory: mainCategory,
            imageLinks: imageLinks,
            language: language
        )
    }
}

extension Book.BookInfo.ImageLinks {

    static func create(_ dict: [AnyHashable:Any]) -> Book.BookInfo.ImageLinks? {
        return Book.BookInfo.ImageLinks(
            thumbnail: (dict["thumbnail"] as? String).flatMap(URL.init)
        )
    }
}

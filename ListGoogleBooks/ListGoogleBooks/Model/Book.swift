//
//  Book.swift
//  ListGoogleBooks
//
//  Created by Abhishek Chatterjee on 23/12/17.
//  Copyright © 2017 Abhishek Chatterjee. All rights reserved.
//

import UIKit

public struct Id<T> {

    public let value: String
    public init(_ value: String) {
        self.value = value
    }
}

public struct Books {
    public let totalItems: Int?
    public let items: [Book]
}

public struct Book {
    public let id: Id<Book>

    public let volumeInfo: BookInfo

    public struct BookInfo {

        public let title: String
        public let subtitle: String?
        public let authors: [String]
        public let publisher: String?
        public let publishedDate: String?
        public let desc: String?
        public let pageCount: Int?
        public let mainCategory: String?
        public let imageLinks: ImageLinks?
        public let language: String?

        public struct ImageLinks {

            public let thumbnail: URL?
        }
    }
}

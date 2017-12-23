import Foundation

private let BASE_URL: URL = URL(string: "https://www.googleapis.com/books/v1")!

public protocol GoogleBooksFetchRequest {

    associatedtype Result
    var request: URLRequest? { get }
}

protocol GoogleBooksFetchRequestType {

    var method: HttpMethod { get }
    var path: String { get }
    var url: URL { get }
    var params: [RequestParameter] { get }
}

extension GoogleBooksFetchRequestType {
    
    var url: URL {
        return BASE_URL.appendingPathComponent(path)
    }
    
    var params: [RequestParameter] {
        return []
    }

    public var request: URLRequest? {
        return URLRequest.create(
            method: method,
            url: url,
            params: params
        )
    }
}

public struct GoogleBooksApi {

    private init() {}

    public struct VolumeRequest {

        private init() {}

        public struct List: GoogleBooksFetchRequest, GoogleBooksFetchRequestType {

            public typealias Result = Books
            private let query: String

            public init(query: String) {
                self.query = query
            }

            var method: HttpMethod {
                return .get
            }

            var path: String {
                return "/volumes"
            }

            var params: [RequestParameter] {
                return [("q", query)]
            }
        }
    }
}

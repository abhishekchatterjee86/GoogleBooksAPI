//
//  GoogleBooksClient.swift
//  ListGoogleBooks
//
//  Created by Abhishek Chatterjee on 23/12/17.
//  Copyright © 2017 Abhishek Chatterjee. All rights reserved.
//

import Foundation

typealias RequestParameter = (key: String, value: String)

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

enum HttpClientError: Error {
    case unknown
    case nonHTTPResponse(response: URLResponse)
}

class GoogleBooksClient: NSObject {

    private let session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func execute(request: URLRequest, completionHandler: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let response = response, let data = data else {
                completionHandler(nil, nil, HttpClientError.unknown)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completionHandler(data, nil, HttpClientError.nonHTTPResponse(response: response))
                return
            }
            completionHandler(data, httpResponse, error)
        })
        return task
    }
}

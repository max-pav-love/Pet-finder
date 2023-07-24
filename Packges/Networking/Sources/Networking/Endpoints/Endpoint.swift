//
//  Endpoint.swift
//  
//
//  Created by Maksim Khlestkin on 12.07.2023.
//

import Foundation

public enum Endpoint {
    case token
    case animals(location: String, page: String)
    
    var path: String {
        switch self {
        case .token:
            return "oauth2/token"
        case .animals:
            return "animals"
        }
    }
    
    var apiUrl: URL {
        let url = Self.host.appendingPathComponent("v2/")
        switch self {
        case .token:
            return url.appendingPathComponent(path)
        case let .animals(location, page):
            return url.appendingPathComponent(path)
                .appending("location", value: location)
                .appending("page", value: page)
                .appending("distance", value: "500")
                .appending("sort", value: "distance")
                .appending("limit", value: "40")
        }
    }
}

extension Endpoint {
    static let base = "https://api.petfinder.com/"
    static let host = URL(string: base)!
}

extension URL {

    func appending(_ queryItem: String, value: String?) -> URL {

        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }

        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        // Create query item
        let queryItem = URLQueryItem(name: queryItem, value: value)

        // Append the new query item in the existing query items array
        queryItems.append(queryItem)

        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems

        // Returns the url from new url components
        return urlComponents.url!
    }
}

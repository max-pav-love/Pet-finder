//
//  Endpoint.swift
//  
//
//  Created by Maksim Khlestkin on 12.07.2023.
//

import Foundation

public enum Endpoint {
    case animal(id: Int)
    case animals
    
    var path: String {
        switch self {
        case .animal(let id):
            return "animals/\(id)"
        case .animals:
            return "animals"
        }
    }
    
    var apiUrl: URL {
        let url = Self.host.appendingPathComponent("v2/")
        switch self {
        case .animal:
            return url.appendingPathComponent(path)
        case .animals:
            return url.appendingPathComponent(path)
        }
    }
}

extension Endpoint {
    static let base = "https://api.petfinder.com/"
    static let host = URL(string: base)!
}

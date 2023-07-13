//
//  File.swift
//  
//
//  Created by Maksim Khlestkin on 12.07.2023.
//

import Foundation

public struct ErrorResponse: LocalizedError, Decodable {
    public let type: String
    public let status: Int
    public let title: String
    public let detail: String
    
    public var errorDescription: String? {
        detail
    }
}

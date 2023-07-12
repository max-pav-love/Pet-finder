//
//  File.swift
//  
//
//  Created by Maksim Khlestkin on 12.07.2023.
//

import Foundation

public struct ErrorResponse: LocalizedError, Decodable {
    public let message: String
    
    public var errorDescription: String? {
        message
    }
}

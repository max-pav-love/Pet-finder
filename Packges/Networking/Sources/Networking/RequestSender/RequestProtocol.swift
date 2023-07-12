//
//  RequestProtocol.swift
//  
//
//  Created by Maksim Khlestkin on 12.07.2023.
//

import Foundation

public protocol RequestProtocol {
    associatedtype Response: Decodable
    
    var endpoint: Endpoint { get }
    var method: HttpMethod { get }
    var response: Response.Type { get }
    
    func parameters() -> [String: Any]?
}

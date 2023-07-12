//
//  AnimalsRequest.swift
//  
//
//  Created by Maksim Khlestkin on 12.07.2023.
//

public struct AnimalsRequest: RequestProtocol {
    public var endpoint: Endpoint = .animals
    public var method: HttpMethod = .get
    public let response = AnimalsResponse.self
    
    public func parameters() -> [String : Any]? { nil }
    
    public init() { }
}

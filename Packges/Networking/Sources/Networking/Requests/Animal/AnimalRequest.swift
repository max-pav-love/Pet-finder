//
//  AnimalRequest.swift
//  
//
//  Created by Maksim Khlestkin on 12.07.2023.
//

public struct AnimalRequest: RequestProtocol {
    public var method: HttpMethod = .get
    public let endpoint: Endpoint
    public let response = AnimalResponse.self

    private let id: Int
    
    public init(id: Int) {
        self.id = id
        self.endpoint = .token
    }
    
    public func parameters() -> [String : Any]? { nil }
}

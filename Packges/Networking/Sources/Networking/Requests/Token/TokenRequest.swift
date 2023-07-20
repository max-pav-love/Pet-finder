//
//  TokenRequest.swift
//  
//
//  Created by Maksim Khlestkin on 13.07.2023.
//

import Foundation

public struct TokenRequest: RequestProtocol {
    public let endpoint: Endpoint = .token
    public let method: HttpMethod = .post
    public var response = TokenResponse.self
    
    public init() { }
    
    public func parameters() -> [String : Any]? {
        [
            "client_id": NetworkConstants.CLIENT_ID,
            "client_secret": NetworkConstants.CLIENT_SECRET,
            "grant_type": "client_credentials"
        ]
    }
}

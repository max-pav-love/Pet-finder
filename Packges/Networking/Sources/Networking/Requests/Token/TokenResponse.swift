//
//  TokenResponse.swift
//  
//
//  Created by Maksim Khlestkin on 13.07.2023.
//

public struct TokenResponse: Decodable {
    public let token_type: String
    public let expires_in: Int
    public let access_token: String
}

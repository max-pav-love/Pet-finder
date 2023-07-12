//
//  AnimalsResponse.swift
//  
//
//  Created by Maksim Khlestkin on 12.07.2023.
//

import Foundation

public struct AnimalsResponse: Decodable {
    public struct Animal: Decodable {
        public struct Photos: Decodable {
            public let small: URL
            public let medium: URL
            public let large: URL
            public let full: URL
        }
        public let gender: String
        public let age: String
        public let size: String
        public let name: String
        public let photos: [Photos]
        public let tags: [String]
    }
    public let animals: [Animal]
}

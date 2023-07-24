//
//  AnimalsResponse.swift
//  
//
//  Created by Maksim Khlestkin on 12.07.2023.
//

import Foundation

public struct AnimalsResponse: Decodable {
    public struct Animal: Decodable {
        public struct Breeds: Decodable {
            public let primary: String
            public let secondary: String?
            public let mixed: Bool?
            public let unknown: Bool?
        }
        public struct Colors: Decodable {
            public let primary: String?
            public let secondary: String?
            public let tertiary: String?
        }
        public struct Contact: Decodable {
            public let email: String?
            public let phone: String?
        }
        public struct Photos: Decodable {
            public let small: URL
            public let medium: URL
            public let large: URL
            public let full: URL
        }
        public let id: Int
        public let gender: String
        public let age: String
        public let size: String
        public let name: String
        public let description: String?
        public let breeds: Breeds
        public let colors: Colors
        public let contact: Contact?
        public let photos: [Photos]
        public let tags: [String]
        public let distance: Double
        public let published_at: String
    }
    public struct Pagination: Decodable {
        public let total_pages: Int
    }
    public let animals: [Animal]
    public let pagination: Pagination
}

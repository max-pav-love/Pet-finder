//
//  AnimalResonse.swift
//  
//
//  Created by Maksim Khlestkin on 12.07.2023.
//

public struct AnimalResponse: Decodable {
    public struct Animal: Decodable {
        public struct Breeds: Decodable {
            public let primary: String
            public let secondary: String?
            public let mixed: Bool
            public let unknown: Bool
        }
        public struct Colors: Decodable {
            public let primary: String
            public let secondary: String?
            public let tertiary: String?
        }
        public struct Contact: Decodable {
            public let email: String
            public let phone: String
        }
        public let type: String
        public let breeds: Breeds
        public let colors: Colors
        public let age: String
        public let gender: String
        public let size: String
        public let name: String
        public let description: String
        public let photos: [String: String]
        public let status: String
        public let contact: Contact
    }
    public let animal: Animal
}

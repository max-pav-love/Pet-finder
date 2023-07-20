//
//  AnimalMainInfoViewObject.swift
//  Pets-Interview
//
//  Created by Maksim Khlestkin on 13.07.2023.
//

import Foundation
import UIComponents

struct AnimalViewObject: Equatable {
    var id: Int
    let name: String
    let description: String
    let gender: PetGender
    let age: String
    let distance: String?
    let publishedAt: String
    let photo: URL?
    let tags: [String]
    let ownersPhone: String?
    let ownersEmail: String?
    let color: String
    let size: String
}

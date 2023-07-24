//
//  AnimalMainInfoViewObject.swift
//  Pets-Interview
//
//  Created by Maksim Khlestkin on 13.07.2023.
//

import Foundation
import UIComponents

struct AnimalViewObject: Equatable {
    struct Tags: Equatable {
        let firstTag: String
        let detailTags: String
    }
    var id: Int
    let name: String
    let description: String
    let gender: PetGender
    let age: String
    let distance: String?
    let publishedAt: String
    let photo: URL?
    let tags: Tags
    let ownersPhone: String?
    let ownersEmail: String?
    let color: String
    let size: String
}

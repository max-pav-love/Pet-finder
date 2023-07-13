//
//  AnimalMainInfoViewObject.swift
//  Pets-Interview
//
//  Created by Maksim Khlestkin on 13.07.2023.
//

import Foundation
import UIComponents

struct AnimalMainInfoViewObject: Identifiable {
    let id = UUID()
    let name: String
    let gender: PetCell.PetGender
    let age: String
    let distance: String?
    let lastSeen: String
    let photo: URL?
    let tags: [String]
}

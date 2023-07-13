//
//  AnimalMainInfoViewObject.swift
//  Pets-Interview
//
//  Created by Maksim Khlestkin on 13.07.2023.
//

import Foundation
import UIComponents

struct AnimalMainInfoViewObject {
    let name: String
    let gender: PetCell.PetGender
    let age: String
    let metersAway: String
    let lastSeen: String
    let photo: URL?
    let tags: [String]
}

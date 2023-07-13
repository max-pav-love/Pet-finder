//
//  AnimalDataMapper.swift
//  Pets-Interview
//
//  Created by Maksim Khlestkin on 13.07.2023.
//

import Foundation
import Networking

protocol AnimalDataMapperProtocol {
    func map(_ data: AnimalsResponse) -> [AnimalMainInfoViewObject]
}

final class AnimalDataMapper: AnimalDataMapperProtocol {
    func map(_ data: AnimalsResponse) -> [AnimalMainInfoViewObject] {
        data.animals.map {
             AnimalMainInfoViewObject(
                name: $0.name,
                gender: $0.gender == "Male" ? .male : .female,
                age: $0.age,
                distance: $0.distance,
                lastSeen: $0.published_at,
                photo: $0.photos.isEmpty ? nil : $0.photos[0].medium,
                tags: $0.tags
            )
        }
    }
}

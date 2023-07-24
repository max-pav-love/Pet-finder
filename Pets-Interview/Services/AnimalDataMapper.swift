//
//  AnimalDataMapper.swift
//  Pets-Interview
//
//  Created by Maksim Khlestkin on 13.07.2023.
//

import Foundation
import Networking

protocol AnimalDataMapperProtocol {
    func map(_ data: AnimalsResponse) -> [AnimalViewObject]
}

final class AnimalDataMapper: AnimalDataMapperProtocol {
    typealias Tags = AnimalViewObject.Tags
    private enum Dates: String {
        case minutes = "min "
        case hours = "h "
        case days = "d "
    }
    
    func map(_ data: AnimalsResponse) -> [AnimalViewObject] {
        data.animals
            .map {
                AnimalViewObject(
                    id: $0.id,
                    name: $0.name,
                    description: map($0.description),
                    gender: $0.gender == "Male" ? .male : .female,
                    age: $0.age,
                    distance: map($0.distance),
                    publishedAt: map($0.published_at),
                    photo: $0.photos.isEmpty ? nil : $0.photos[0].medium,
                    tags: map($0.tags),
                    ownersPhone: $0.contact.phone,
                    ownersEmail: $0.contact.email,
                    color: map($0.colors),
                    size: $0.size
                )
            }
    }
    
    private func map(_ rawDistance: Double) -> String {
        Int(rawDistance.rounded()).description + "m away"
    }
    
    private func map(_ colors: AnimalsResponse.Animal.Colors) -> String {
        if let primary = colors.primary { return primary }
        if let secondary = colors.secondary { return secondary }
        if let tertiary = colors.tertiary { return tertiary }
        else { return "No Data" }
    }
    
    private func map(_ description: String?) -> String {
        guard let description else {
            return "There is no story yet :("
        }
        return description
    }
    
    private func map(_ rawData: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: rawData)!
        let dateResult = Calendar.current.dateComponents(
            [.hour, .minute, .day], from: date, to: Date())
        
        guard let days = map(date: dateResult.day, type: .days) else {
            let hours = map(date: dateResult.hour, type: .hours)
            let minutes = map(date: dateResult.minute, type: .minutes)
            return (hours ?? "") + (minutes ?? "") + "ago"
        }
        return days + "ago"
    }
    
    private func map(date: Int?, type: Dates) -> String? {
        guard let date, date != 0 else { return nil }
        return date.description + type.rawValue
    }
    
    private func map(_ tags: [String]) -> Tags {
        guard let firtsTag = tags.first else {
            return .init(firstTag: "", detailTags: "")
        }
        var output = tags
        if output.count > 3 {
            output.removeSubrange(3...tags.count - 1)
        }
        return .init(
            firstTag: " | " + firtsTag,
            detailTags: output.joined(separator: " | ")
        )
    }
    
}

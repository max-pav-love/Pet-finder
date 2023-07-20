//
//  PetCell.swift
//  
//
//  Created by Maksim Khlestkin on 13.07.2023.
//

import SwiftUI
import Kingfisher

public struct PetCell: View {
    
    private let name: String
    private let tags: [String]
    private let age: String
    private let distance: String?
    private let photo: URL?
    private let gender: PetGender
    private let publishedAt: String
    
    public init(
        name: String,
        tags: [String],
        age: String,
        distance: String?,
        photo: URL?,
        gender: PetGender,
        publishedAt: String
    ) {
        self.name = name
        self.tags = tags
        self.age = age
        self.distance = distance
        self.photo = photo
        self.gender = gender
        self.publishedAt = publishedAt
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.init(appColor: .appLightBackground))

            HStack {
                AppImage(url: photo)
                    .frame(width: 96, height: 96)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                PetMainInfoStack(
                    stackType: .list(tags: tags, age: age),
                    metersAway: distance,
                    name: name
                )
                .padding(.vertical)
                .padding(.leading)
                
                Spacer()
                GenderStack(gender: gender, additionalText: publishedAt)
                .padding(.vertical)
            }
            .padding(.horizontal)
        }
        .frame(height: 120)
        .padding(.horizontal)
    }
        
}

struct PetCell_Previews: PreviewProvider {
    static var previews: some View {
        PetCell(
            name: "Parkinson",
            tags: ["Playful"],
            age: "2yrs",
            distance: "381m away",
            photo: nil,
            gender: .female,
            publishedAt: "13 min ago"
        )
    }
}

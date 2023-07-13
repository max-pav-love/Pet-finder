//
//  SwiftUIView.swift
//  
//
//  Created by Maksim Khlestkin on 13.07.2023.
//

import SwiftUI

public struct SwiftUIView: View {
    private let name: String
    private let tags: [String]
    private let age: String
    private let distance: String
    private let photo: Image
    private let gender: String
    private let lastSeen: String
    
    public init(
        name: String,
        tags: [String],
        age: String,
        distance: String,
        photo: Image,
        gender: String,
        lastSeen: String
    ) {
        self.name = name
        self.tags = tags
        self.age = age
        self.distance = distance
        self.photo = photo
        self.gender = gender
        self.lastSeen = lastSeen
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(height: 120)
                .foregroundColor(.gray)
            HStack {
                Image("Mock_Pet", bundle: .module)
                    .frame(width: 96, height: 96)
                petMainInfoView
                VStack {
                    petGenderView
                    lastSeenView
                }
            }
        }
        .padding(.horizontal, 20)
    }
    
    private var petMainInfoView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(name)
            HStack {
                Text(age)
                Text("|")
                Text(tags.first!)
            }
            HStack(spacing: 8) {
                Image("Pin", bundle: .module)
                    .frame(width: 16, height: 16)
                Text(distance)
            }
        }
    }
    
    private var petGenderView: some View {
        Text(gender)
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(.blue)
            )
    }
    
    private var lastSeenView: some View {
        Text(lastSeen)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView(
            name: "Parkinson",
            tags: ["Playful"],
            age: "2yrs",
            distance: "381m away",
            photo: Image("chevron.left"),
            gender: "Male",
            lastSeen: "13 min ago"
        )
    }
}

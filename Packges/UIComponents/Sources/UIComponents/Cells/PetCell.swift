//
//  PetCell.swift
//  
//
//  Created by Maksim Khlestkin on 13.07.2023.
//

import SwiftUI

public struct PetCell: View {
    public enum PetGender: String {
        case male
        case female
        
        var backgroundColor: Color {
            switch self {
            case .male: return .init(appColor: .appBlueLight)
            case .female: return .init(appColor: .appRedLight)
            }
        }
        
        var textColor: Color {
            switch self {
            case .male: return .init(appColor: .appTextBlue)
            case .female: return .init(appColor: .appRed)
            }
        }
    }
    
    private let name: String
    private let tags: [String]
    private let age: String
    private let distance: String
    private let photo: Image
    private let gender: PetGender
    private let lastSeen: String
    private let action: () -> Void
    
    public init(
        name: String,
        tags: [String],
        age: String,
        distance: String,
        photo: Image,
        gender: PetGender,
        lastSeen: String,
        action: @escaping () -> Void
    ) {
        self.name = name
        self.tags = tags
        self.age = age
        self.distance = distance
        self.photo = photo
        self.gender = gender
        self.lastSeen = lastSeen
        self.action = action
    }
    
    public var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .frame(height: 120)
                    .foregroundColor(.init(appColor: .appLightBackground))
                HStack(alignment: .center) {
                    HStack(spacing: 18) {
                        Image("Mock_Pet", bundle: .module)
                            .frame(width: 96, height: 96)
                        petMainInfoView
                    }
                    VStack {
                        petGenderView
                            .padding(.vertical)
                        lastSeenView
                            .padding(.vertical)
                    }
                    .padding(.leading, 45)
                }
            }
            .frame(height: 120)
            .padding(.horizontal, 20)
        }
    }
    
    private var petMainInfoView: some View {
        VStack(alignment: .leading) {
            VStack(spacing: 10) {
                Text(name)
                    .foregroundColor(.init(appColor: .appTextPrimary))
                    .font(AppFonts.Sailec.medium.swiftUIFont(fixedSize: 16))
                HStack {
                    Text(age)
                        .foregroundColor(.init(appColor: .appTextPrimary))
                        .font(AppFonts.Sailec.regular.swiftUIFont(fixedSize: 12))
                    Text("|")
                        .foregroundColor(.init(appColor: .appTextPrimary))
                        .font(AppFonts.Sailec.regular.swiftUIFont(fixedSize: 12))
                    Text(tags.first!)
                        .foregroundColor(.init(appColor: .appTextPrimary))
                        .font(AppFonts.Sailec.regular.swiftUIFont(fixedSize: 12))
                }
            }
            HStack(spacing: 8) {
                Image("Pin", bundle: .module)
                    .frame(width: 16, height: 16)
                Text(distance)
                    .font(AppFonts.Sailec.regular.swiftUIFont(fixedSize: 12))
                    .foregroundColor(.init(appColor: .appTextPrimary))
            }
            .padding(.top, 12)
        }
    }
    
    private var petGenderView: some View {
        Text(gender.rawValue.uppercased())
            .foregroundColor(gender.textColor)
            .font(AppFonts.Sailec.regular.swiftUIFont(fixedSize: 12))
            .padding(.horizontal, 12)
            .padding(.vertical, 5)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(gender.backgroundColor)
            )
    }
    
    private var lastSeenView: some View {
        Text(lastSeen)
            .foregroundColor(.init(appColor: .appTextPrimary))
            .font(AppFonts.Sailec.regular.swiftUIFont(fixedSize: 12))
    }
}

struct PetCell_Previews: PreviewProvider {
    static var previews: some View {
        PetCell(
            name: "Parkinson",
            tags: ["Playful"],
            age: "2yrs",
            distance: "381m away",
            photo: Image("chevron.left"),
            gender: .female,
            lastSeen: "13 min ago"
        ) { }
    }
}

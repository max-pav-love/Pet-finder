//
//  PetCell.swift
//  
//
//  Created by Maksim Khlestkin on 13.07.2023.
//

import SwiftUI
import Kingfisher

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
    private let distance: String?
    private let photo: URL?
    private let gender: PetGender
    private let lastSeen: String
    private let action: () -> Void
    
    public init(
        name: String,
        tags: [String],
        age: String,
        distance: String?,
        photo: URL?,
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
            label
        }
    }
    
    private var label: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.init(appColor: .appLightBackground))

            HStack {
                AppImage(url: photo)
                    .frame(width: 96, height: 96)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                VStack(alignment: .leading) {
                    Text(name)
                        .foregroundColor(.init(appColor: .appTextPrimary))
                        .font(AppFonts.Sailec.medium.swiftUIFont(fixedSize: 16))
                    Spacer()
                    HStack(spacing: 4) {
                        Text(age)
                            .foregroundColor(.init(appColor: .appTextPrimary))
                            .font(AppFonts.Sailec.regular.swiftUIFont(fixedSize: 12))
                        if !tags.isEmpty {
                            Text("|")
                                .foregroundColor(.init(appColor: .appTextPrimary))
                                .font(AppFonts.Sailec.regular.swiftUIFont(fixedSize: 12))
                            Text(tags.first!)
                                .foregroundColor(.init(appColor: .appTextPrimary))
                                .font(AppFonts.Sailec.regular.swiftUIFont(fixedSize: 12))
                        }
                    }
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    Spacer()
                    HStack(spacing: 8) {
                        Image("Pin", bundle: .module)
                            .frame(width: 16, height: 16)
                        Text(distance == nil ? "No data" : distance.unsafelyUnwrapped)
                            .font(AppFonts.Sailec.regular.swiftUIFont(fixedSize: 12))
                            .foregroundColor(.init(appColor: .appTextPrimary))
                    }
                }
                .padding(.vertical)
                .padding(.leading)
                
                Spacer()

                VStack(alignment: .trailing) {
                    Text(gender.rawValue.capitalized(with: .current))
                        .foregroundColor(gender.textColor)
                        .font(AppFonts.Sailec.regular.swiftUIFont(fixedSize: 12))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundColor(gender.backgroundColor)
                        )
                    Spacer()
                    Text(lastSeen)
                        .foregroundColor(.init(appColor: .appTextPrimary))
                        .font(AppFonts.Sailec.regular.swiftUIFont(fixedSize: 12))
                }
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
            lastSeen: "13 min ago"
        ) { }
    }
}

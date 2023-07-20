//
//  PetMainInfoStack.swift
//  
//
//  Created by Maksim Khlestkin on 14.07.2023.
//

import SwiftUI

public struct PetMainInfoStack: View {
    
    private let stackType: PetMainInfoStackType
    private let metersAway: String?
    private let name: String
    
    public init(
        stackType: PetMainInfoStackType,
        metersAway: String?,
        name: String
    ) {
        self.stackType = stackType
        self.metersAway = metersAway
        self.name = name
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text(name)
                .foregroundColor(.init(appColor: .appTextPrimary))
                .font(stackType.nameFont)
            Spacer()
            
            switch stackType {
            case let .list(tags, age):
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
                distanceStack
            case let .detail(lastSeen):
                distanceStack
                Text(lastSeen)
                    .foregroundColor(.init(appColor: .appTextPrimary))
                    .font(AppFonts.Sailec.regular.swiftUIFont(fixedSize: 12))
            }
        }
    }
    private var distanceStack: some View {
        HStack(spacing: 8) {
            Image(appImage: .Pin)
                .frame(width: 16, height: 16)
            Text(metersAway == nil ? "??? m away" : metersAway.unsafelyUnwrapped)
                .font(AppFonts.Sailec.regular.swiftUIFont(fixedSize: 12))
                .foregroundColor(.init(appColor: .appTextPrimary))
        }
    }
}

struct PetMainInfoStack_Previews: PreviewProvider {
    static var previews: some View {
        PetMainInfoStack(
            stackType: .list(tags: ["22"], age: "2yrs"),
            metersAway: "12 m",
            name: "Peterson"
        )
    }
}

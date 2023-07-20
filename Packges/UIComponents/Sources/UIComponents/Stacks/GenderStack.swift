//
//  GenderStack.swift
//  
//
//  Created by Maksim Khlestkin on 14.07.2023.
//

import SwiftUI

public struct GenderStack: View {
    private let gender: PetGender
    private let additionalText: String
    
    public init(gender: PetGender, additionalText: String) {
        self.gender = gender
        self.additionalText = additionalText
    }
    
    public var body: some View {
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
            Text(additionalText)
                .foregroundColor(.init(appColor: .appTextPrimary))
                .font(AppFonts.Sailec.regular.swiftUIFont(fixedSize: 12))
        }
    }
    
}

struct GenderStack_Previews: PreviewProvider {
    static var previews: some View {
        GenderStack(gender: .female, additionalText: "12 min ago")
    }
}

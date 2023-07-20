//
//  QuickInfoCell.swift
//  
//
//  Created by Maksim Khlestkin on 13.07.2023.
//

import SwiftUI

public struct QuickInfoCell: View {
    private let title: String
    private let description: String
    
    @Environment(\.colorScheme) private var scheme
    
    public init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(appColor: .appStroke), lineWidth: scheme == .dark ? 0 : 0.4)
                .foregroundColor(Color(appColor: .appLightGray))
            VStack(spacing: 4) {
                Text(title)
                    .font(AppFonts.Sailec.medium.swiftUIFont(size: 16))
                    .foregroundColor(.init(appColor: .appTextSecondary))
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                Text(description)
                    .font(AppFonts.Sailec.regular.swiftUIFont(size: 10))
                    .foregroundColor(.init(appColor: .appTextAdditional))
            }
        }
        .frame(width: 91, height: 60)
    }
}

struct QuickInfoCell_Previews: PreviewProvider {
    static var previews: some View {
        QuickInfoCell(title: "1.4 yrs", description: "Age")
    }
}

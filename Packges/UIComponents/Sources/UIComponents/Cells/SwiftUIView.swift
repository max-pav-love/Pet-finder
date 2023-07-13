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
    
    public init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.gray)
            VStack {
                Text(title)
                Text(description)
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

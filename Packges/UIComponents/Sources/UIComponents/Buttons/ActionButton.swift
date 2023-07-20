//
//  ActionButton.swift
//  
//
//  Created by Maksim Khlestkin on 13.07.2023.
//

import SwiftUI

public struct ActionButton: View {
    private let title: String
    private let action: () -> Void
    
    public init(title: String, action: @escaping () -> Void) {
        self.action = action
        self.title = title
    }
    
    public var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.blue)
                Text(title)
                    .foregroundColor(.white)
            }
            .frame(height: 52)
        }
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(title: "Adopt me") { }
    }
}

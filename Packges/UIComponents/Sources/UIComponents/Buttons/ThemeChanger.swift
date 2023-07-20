//
//  File.swift
//  
//
//  Created by Maksim Khlestkin on 13.07.2023.
//

import Foundation
import SwiftUI

public struct ThemeChanger: View {
    @Environment(\.colorScheme) var scheme
    
    public init() { }
    
    public var body: some View {
        Button {
            preferredColorScheme(scheme == .dark ? .light : .light)
        } label: {
            Image(appImage: scheme == .dark ? .Dark : .Light)
        }
        .environment(\.colorScheme, scheme == .dark ? .light : .dark)
    }
}

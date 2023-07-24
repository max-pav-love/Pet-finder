//
//  File.swift
//  
//
//  Created by Maksim Khlestkin on 13.07.2023.
//

import Foundation
import SwiftUI

public struct ThemeChanger: View {
    @Binding private var colorScheme: ColorScheme?
    
    public init(colorScheme: Binding<ColorScheme?>) {
        _colorScheme = colorScheme
    }
        
    public var body: some View {
        Button {
            colorScheme = colorScheme == .light ? .dark : .light
        } label: {
            Image(appImage: colorScheme == .dark ? .Dark : .Light)
        }
    }
}

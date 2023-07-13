//
//  File.swift
//  
//
//  Created by Maksim Khlestkin on 13.07.2023.
//

import SwiftUI

public extension Color {
    init(appColor: AppColors) {
        self.init(appColor.rawValue, bundle: .module)
    }
}

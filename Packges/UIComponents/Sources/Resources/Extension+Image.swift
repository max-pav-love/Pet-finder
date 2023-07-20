//
//  File.swift
//  
//
//  Created by Maksim Khlestkin on 20.07.2023.
//

import SwiftUI

public extension Image {
    init(appImage: AppImages) {
        self.init(appImage.rawValue, bundle: .module)
    }
}

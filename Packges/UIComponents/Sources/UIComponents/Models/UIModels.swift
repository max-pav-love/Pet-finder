//
//  UIModels.swift
//  
//
//  Created by Maksim Khlestkin on 14.07.2023.
//

import SwiftUI

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

public enum PetMainInfoStackType {
    case list(tags: [String], age: String)
    case detail(lastSeen: String)
    
    var nameFont: SwiftUI.Font {
        switch self {
        case .list:
            return AppFonts.Sailec.medium.swiftUIFont(fixedSize: 16)
        case .detail:
            return AppFonts.Sailec.bold.swiftUIFont(size: 24)
        }
    }
}

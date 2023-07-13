//
//  AppImage.swift
//  
//
//  Created by Maksim Khlestkin on 13.07.2023.
//

import SwiftUI
import Kingfisher

public struct AppImage: View {
    private let url: URL?
    
    public init(url: URL?) {
        self.url = url
    }
    
    public var body: some View {
        if url == nil {
            EmptyView()
        } else {
            KFImage(url)
                .resizable()
                .placeholder { ProgressView() }
                .scaledToFit()
                .frame(width: 96, height: 96)
        }
    }
}

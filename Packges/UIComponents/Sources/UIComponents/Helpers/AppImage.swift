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
            Image(appImage: .No_Image)
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            KFImage(url)
                .resizable()
                .placeholder { ProgressView() }
                .aspectRatio(contentMode: .fill)
        }
    }
}

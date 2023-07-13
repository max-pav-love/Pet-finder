//
//  ViewReader.swift
//  MBRO
//
//  Created by Maksim Khlestkin on 13.07.2023.
//

import SwiftUI

// MARK: - Size Reader -

public struct SizePreferenceKey: PreferenceKey {
    public static var defaultValue: CGSize = .zero
    public static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

// MARK: - Extension: View (readSize) -

public extension View {
    /// Get view up-to-date size
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

// MARK: - Frame Reader -

public struct FramePreferenceKey: PreferenceKey {
    public static var defaultValue: CGRect = .zero
    public static func reduce(value: inout CGRect, nextValue: () -> CGRect) {}
}

// MARK: - Extension: View (readFrame) -

public extension View {
    /// Get view up-to-date frame
    func readFrame(
        coordinateSpace: CoordinateSpace = .global,
        onChange: @escaping (CGRect) -> Void
    ) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(
                        key: FramePreferenceKey.self,
                        value: geometryProxy.frame(in: coordinateSpace)
                    )
            }
        )
        .onPreferenceChange(FramePreferenceKey.self, perform: onChange)
    }
}

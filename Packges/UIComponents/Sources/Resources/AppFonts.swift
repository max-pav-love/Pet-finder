//
//  File.swift
//  
//
//  Created by Maksim Khlestkin on 13.07.2023.
//

import UIKit.UIFont
import SwiftUI

public typealias Font = FontConvertible.Font

// MARK: - Fonts

public enum AppFonts {
  public enum Sailec {
      public static let black = FontConvertible(name: "Sailec-Black", family: "Sailec", path: "Sailec-Black.ttf")
      public static let blackItalic = FontConvertible(name: "Sailec-Black-Italic", family: "Sailec", path: "Sailec-Black-Italic.ttf")
      public static let bold = FontConvertible(name: "Sailec-Bold", family: "Sailec", path: "Sailec-Bold.ttf")
      public static let boldItalic = FontConvertible(name: "Sailec-Bold-Italic", family: "Sailec", path: "Sailec-Bold-Italic.ttf")
      public static let hairline = FontConvertible(name: "Sailec-Hairline", family: "Sailec", path: "Sailec-Hairline.ttf")
      public static let hairlineItalic = FontConvertible(name: "Sailec-Hairline-Italic", family: "Sailec", path: "Sailec-Hairline-Italic.ttf")
      public static let light = FontConvertible(name: "Sailec-Light", family: "Sailec", path: "Sailec-Light.ttf")
      public static let lightItalic = FontConvertible(name: "Sailec-Light-Italic", family: "Sailec", path: "Sailec-Light-Italic.ttf")
      public static let medium = FontConvertible(name: "Sailec-Medium", family: "Sailec", path: "Sailec-Medium.ttf")
      public static let mediumItalic = FontConvertible(name: "Sailec-Medium-Italic", family: "Sailec", path: "Sailec-Medium-Italic.ttf")
      public static let regular = FontConvertible(name: "Sailec-Regular", family: "Sailec", path: "Sailec-Regular.ttf")
      public static let regularItalic = FontConvertible(name: "Sailec-Regular-Italic", family: "Sailec", path: "Sailec-Regular-Italic.ttf")
      public static let thin = FontConvertible(name: "Sailec-Thin", family: "Sailec", path: "Sailec-Thin.ttf")
      public static let thinItalic = FontConvertible(name: "Sailec-Thin-Italic", family: "Sailec", path: "Sailec-Thin-Italic.ttf")
      
      public static let all: [FontConvertible] = [black, blackItalic, bold, boldItalic, hairline, hairlineItalic, light, lightItalic, medium, mediumItalic, regular, regularItalic, thin, thinItalic]
  }
  public static let allCustomFonts: [FontConvertible] = [Sailec.all].flatMap { $0 }
  public static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}

// MARK: - Implementation Details

public struct FontConvertible {
  public let name: String
  public let family: String
  public let path: String

  public typealias Font = UIFont

  public func font(size: CGFloat) -> Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    return font
  }

    @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public func swiftUIFont(size: CGFloat) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, size: size)
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
  public func swiftUIFont(fixedSize: CGFloat) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, fixedSize: fixedSize)
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
  public func swiftUIFont(size: CGFloat, relativeTo textStyle: SwiftUI.Font.TextStyle) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, size: size, relativeTo: textStyle)
  }

  public func register() {
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate func registerIfNeeded() {
    if !UIFont.fontNames(forFamilyName: family).contains(name) {
      register()
    }
  }

  fileprivate var url: URL? {
    return BundleToken.bundle.url(forResource: path, withExtension: nil)
  }
}

public extension FontConvertible.Font {
  convenience init?(font: FontConvertible, size: CGFloat) {
    font.registerIfNeeded()
    self.init(name: font.name, size: size)
  }
}

@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Font {
  static func custom(_ font: FontConvertible, size: CGFloat) -> SwiftUI.Font {
    font.registerIfNeeded()
    return custom(font.name, size: size)
  }
}

@available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
public extension SwiftUI.Font {
  static func custom(_ font: FontConvertible, fixedSize: CGFloat) -> SwiftUI.Font {
    font.registerIfNeeded()
    return custom(font.name, fixedSize: fixedSize)
  }

  static func custom(
    _ font: FontConvertible,
    size: CGFloat,
    relativeTo textStyle: SwiftUI.Font.TextStyle
  ) -> SwiftUI.Font {
    font.registerIfNeeded()
    return custom(font.name, size: size, relativeTo: textStyle)
  }
}

private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}

//
//  Color+Codable.swift
//  Home Control
//
//  Created by Konstantin Zyrianov on 2022-02-23.
//

import SwiftUI

#if os(iOS)
import UIKit
#elseif os(watchOS)
import WatchKit
#elseif os(macOS)
import AppKit
#endif

extension Color {
    #if os(macOS)
    typealias SystemColor = NSColor
    #else
    typealias SystemColor = UIColor
    #endif

    var colorComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        #if os(macOS)
        SystemColor(self).getRed(&r, green: &g, blue: &b, alpha: &a)
        // Note that non RGB color will raise an exception, that I don't now how to catch because it is an Objc exception.
        #else
        guard SystemColor(self).getRed(&r, green: &g, blue: &b, alpha: &a) else {
            // Pay attention that the color should be convertible into RGB format
            // Colors using hue, saturation and brightness won't work
            return nil
        }
        #endif

        return (r, g, b, a)
    }

    var hexString: String? {
        guard let colorComponents = self.colorComponents else {
            return nil
        }
        let red = Int(round(colorComponents.red * 255))
        let green = Int(round(colorComponents.green * 255))
        let blue = Int(round(colorComponents.blue * 255))
        let alpha = Int(round(colorComponents.alpha * 255))
        let hex = (red << 24) | (green << 16) | (blue << 8) | (alpha)
        return "#"+String(format: "%08x", hex)
    }
}

extension Color: Codable {
    enum CodingError: Error {
        case unableToEncode(String)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let hex = try container.decode(String.self)
        self.init(hexString: hex)
    }

    public func encode(to encoder: Encoder) throws {
        guard let hexString = self.hexString else {
            throw CodingError.unableToEncode(self.description)
        }

        var container = encoder.singleValueContainer()
        try container.encode(hexString)
    }
}

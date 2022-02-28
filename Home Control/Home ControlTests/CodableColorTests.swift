//
//  CodableColorHex.swift
//  Home ControlTests
//
//  Created by Konstantin Zyrianov on 2022-02-24.
//

import SwiftUI
import XCTest
@testable import Home_Control

class CodableColorTests: XCTestCase {
    func testCodable() throws {
        let colors = [
            Color.green,
            Color.yellow,
            Color.red,
            Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0),
            Color(red: 0.0, green: 1.0, blue: 0.0, opacity: 1.0),
            Color(red: 0.0, green: 0.0, blue: 1.0, opacity: 1.0),
            Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.5),
            Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.0),
            Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 1.0),
        ]

        try colors.forEach { color in
            let encoded = try JSONEncoder().encode(color)
            let decoded = try JSONDecoder().decode(Color.self, from: encoded)

            let colorComponents = try XCTUnwrap(color.colorComponents)
            let decodedComponents = try XCTUnwrap(decoded.colorComponents)

            XCTAssert(color.hexString == decoded.hexString)
            XCTAssert(approximateCompare(colorComponents.red, decodedComponents.red, epsilon: 0.01))
            XCTAssert(approximateCompare(colorComponents.green, decodedComponents.green, epsilon: 0.01))
            XCTAssert(approximateCompare(colorComponents.blue, decodedComponents.blue, epsilon: 0.01))
            XCTAssert(approximateCompare(colorComponents.alpha, decodedComponents.alpha, epsilon: 0.01))
        }
    }

    private func approximateCompare<E: FloatingPoint>(_ lhs: E, _ rhs: E, epsilon: E = E.ulpOfOne) -> Bool {
        abs(lhs - rhs) <= epsilon
    }
}

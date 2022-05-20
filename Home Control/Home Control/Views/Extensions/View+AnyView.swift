//
//  View+AnyView.swift
//  Home Control
//
//  Created by Konstantin Zyrianov on 2022-02-15.
//

import Foundation
import SwiftUI

extension View {
    func anyView() -> AnyView {
        AnyView(self)
    }
}

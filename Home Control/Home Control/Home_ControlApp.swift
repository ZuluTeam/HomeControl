//
//  Home_ControlApp.swift
//  Home Control
//
//  Created by Konstantin Zyrianov on 2022-02-03.
//

import SwiftUI

@main
struct Home_ControlApp: App {
    init() {
        UIApplication.shared.isIdleTimerDisabled = true
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

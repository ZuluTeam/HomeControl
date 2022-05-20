//
//  Reminder.swift
//  Home Control
//
//  Created by Konstantin Zyrianov on 2022-02-19.
//

import Foundation
import SwiftUI

struct Reminder: Equatable, Identifiable {
    struct Deadline: Equatable {
        let color: String
        let icon: String
        let timeInterval: TimeInterval
    }

    let id: UUID

    let date: Date
    let deadlines: [Deadline]
    let image: Image
}

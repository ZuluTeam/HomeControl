//
//  ReminderViewModel.swift
//  Home Control
//
//  Created by Konstantin Zyrianov on 2022-02-03.
//

import Foundation
import Combine
import SwiftUI

final class ReminderViewModel: ObservableObject {

    enum TouchState: Equatable {
        case idle
        case updating(location: CGPoint, touchDownTime: Date, progress: CGFloat)
        case finished
    }

    struct Deadline {
        let timeInterval: TimeInterval
        let color: Color
        let icon: String
    }

    static let touchTimeInterval: TimeInterval = 1.0

    static let hourTimeInterval: TimeInterval = 60*60
    static let deadlines: [Deadline] = [
        Deadline(timeInterval: 0, color: .green, icon: "😸"),
        Deadline(timeInterval: hourTimeInterval*24, color: .yellow, icon: "😿"),
        Deadline(timeInterval: hourTimeInterval*36, color: .orange, icon: "😾"),
        Deadline(timeInterval: hourTimeInterval*48, color: .red, icon: "🙀")
    ]

    @Published var checkedDate: Date = Date()
    @Published var deadline: Deadline = deadlines.first!

    @Published var touchState: TouchState = .idle

    private var cancellables: Set<AnyCancellable> = []

    init() {
        Timer.publish(every: Self.hourTimeInterval, on: .main, in: .common).autoconnect().sink(receiveValue: { [unowned self] _ in
            let timeInterval = abs(checkedDate.timeIntervalSinceNow)
            let hours = timeInterval/(Self.hourTimeInterval)
            switch hours {
            case (0..<24):
                deadline = Self.deadlines[0]
            case (24..<36):
                deadline = Self.deadlines[1]
            case (36..<48):
                deadline = Self.deadlines[2]
            default:
                deadline = Self.deadlines[3]
            }
        }).store(in: &cancellables)
    }

    func check() {
        checkedDate = Date()
        deadline = Self.deadlines[0]
    }
}

//
//  RemindersRouter.swift
//  Home Control
//
//  Created by Konstantin Zyrianov on 2022-02-15.
//

import Foundation
import Combine
import SwiftUI

protocol Router {
    associatedtype Content: View

    func makeInitialView() -> Content
}

final class RemindersRouter: Router {
    private let presentCreateReminder: CurrentValueSubject<Bool, Never> = CurrentValueSubject(false)

    func makeInitialView() -> some View {
        RemindersView(delegate: self)
            .sheet(isPresented: presentCreateReminder) {
                AddReminderView()
                    
            }
    }
}

extension RemindersRouter: RemindersViewDelegate {
    func didPressCreateReminder(label: () -> AnyView) -> some View {
        Button(action: { [unowned self] in
            presentCreateReminder.value = true
        }, label: label)
    }
}

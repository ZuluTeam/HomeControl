//
//  RemindersView.swift
//  Home Control
//
//  Created by Konstantin Zyrianov on 2022-02-14.
//

import SwiftUI

protocol RemindersViewDelegate: AnyObject {
    associatedtype Link: View
    func didPressCreateReminder(label: () -> AnyView) -> Link
}

struct RemindersView<Delegate: RemindersViewDelegate>: View {
    unowned let delegate: Delegate

    @State var presentSheet: Bool = false

    private let columns: [GridItem] = [
        .init(.flexible(minimum: 100, maximum: .infinity), spacing: 1),
        .init(.flexible(minimum: 100, maximum: .infinity), spacing: 1),
        .init(.flexible(minimum: 100, maximum: .infinity), spacing: 1),
    ]

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 1) {
                ForEach(0..<100, id: \.self) { _ in
                    ReminderView(viewModel: ReminderViewModel())
                }
            }
            .background(Color.black)
        }
            delegate.didPressCreateReminder() {
                Image(systemName: "plus")
                    .resizable()
                    .padding()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.primary)
                    .background(.background)
                    .clipShape(Circle())
                    .padding()
                    .shadow(color: .black, radius: 3)
                    .anyView()
            }
        }
    }
}

struct RemindersView_Previews: PreviewProvider {
    private class Delegate: RemindersViewDelegate {
        func didPressCreateReminder(label: () -> AnyView) -> some View {
            label()
        }
    }

    private static let delegate = Delegate()

    static var previews: some View {
        RemindersView(delegate: delegate)
    }
}

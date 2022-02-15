//
//  RemindersView.swift
//  Home Control
//
//  Created by Konstantin Zyrianov on 2022-02-14.
//

import SwiftUI

struct RemindersView: View {
    private let columns: [GridItem] = [
        .init(.flexible(minimum: 100, maximum: .infinity), spacing: 1),
        .init(.flexible(minimum: 100, maximum: .infinity), spacing: 1),
        .init(.flexible(minimum: 100, maximum: .infinity), spacing: 1),
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 1) {
                ForEach(0..<100, id: \.self) { _ in
                    ReminderView(viewModel: ReminderViewModel())
                }
            }
            .background(Color.black)
        }
    }
}

struct RemindersView_Previews: PreviewProvider {
    static var previews: some View {
        RemindersView()
    }
}

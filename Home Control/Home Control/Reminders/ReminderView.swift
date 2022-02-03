//
//  ReminderView.swift
//  Home Control
//
//  Created by Konstantin Zyrianov on 2022-02-03.
//

import SwiftUI

struct ReminderView: View {

    @ObservedObject var viewModel: ReminderViewModel

    var body: some View {
        Text(viewModel.deadline.icon)
            .font(.system(size: 100))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(viewModel.deadline.color)
            .gesture(TapGesture().onEnded(viewModel.check))
            .contentShape(Rectangle())
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView(viewModel: ReminderViewModel())
    }
}

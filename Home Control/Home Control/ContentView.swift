//
//  ContentView.swift
//  Home Control
//
//  Created by Konstantin Zyrianov on 2022-02-03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ReminderView(viewModel: ReminderViewModel())
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

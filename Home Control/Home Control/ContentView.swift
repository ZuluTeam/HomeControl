//
//  ContentView.swift
//  Home Control
//
//  Created by Konstantin Zyrianov on 2022-02-03.
//

import SwiftUI

struct ContentView: View {
    let remindersRouter = RemindersRouter(services: ServiceConfiguration.memory)

    var body: some View {
        remindersRouter
            .makeInitialView()
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

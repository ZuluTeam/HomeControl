//
//  AddReminderView.swift
//  Home Control
//
//  Created by Konstantin Zyrianov on 2022-02-15.
//

import DynamicColor
import Foundation
import SwiftUI

struct AddReminderView: View {
    @State private var title: String = ""
    @State private var date: Date?
    @State private var deadlines: [Reminder.Deadline] = [
        .init(color: "#FF0000", icon: "🙂", timeInterval: 24),
        .init(color: "#00FF00", icon: "😕", timeInterval: 36),
        .init(color: "#0000FF", icon: "☹️", timeInterval: 48),
    ]

    var body: some View {
        VStack {
            HStack {
                Button(
                    action: {
                    },
                    label: {
                        VStack {
                            Image(systemName: "plus")
                            Text("Add image")
                        }
                    }
                )
                VStack {
                    TextField(
                        text: .constant(""),
                        prompt: Text("Title")
                    ) {
                        Text("Label")
                    }
                    TextField(
                        text: .constant(""),
                        prompt: Text("Description")
                    ) {
                        Text("Label")
                    }
                }
            }
            ScrollView {
                LazyVStack {
                    ForEach(0..<deadlines.count, id: \.self) { index in
                        let deadline = deadlines[index]
                        DeadlineView(deadline: deadline)
                    }
                }
            }
        }
    }
}

extension AddReminderView {
    struct DeadlineView: View {
        let deadline: Reminder.Deadline

        var body: some View {
            HStack {
                Text(deadline.color)
                Text(deadline.icon)
                Text("\(deadline.timeInterval)")
            }
        }
    }
}

struct AddReminderView_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
            .sheet(isPresented: .constant(true)) {
                AddReminderView()
            }
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

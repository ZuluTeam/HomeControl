//
//  ReminderView.swift
//  Home Control
//
//  Created by Konstantin Zyrianov on 2022-02-03.
//

import SwiftUI

struct ReminderView: View {

    @ObservedObject var viewModel: ReminderViewModel

    private let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()

    @State var showRect: Bool = false

    var body: some View {
        ZStack {
            Text(viewModel.deadline.icon)
                .font(.system(size: 100))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(viewModel.deadline.color)
                .contentShape(Rectangle())
            if case .updating(let location, _, let progress) = viewModel.touchState {
                ProgressView(progress: progress)
                    .frame(
                        width: Self.progressViewSize,
                        height: Self.progressViewSize
                    )
                    .rotationEffect(.degrees(270))
                    .position(x: location.x, y: location.y)
                    .onReceive(timer) { date in
                        switch viewModel.touchState {
                        case .updating(_, _, let progress) where progress >= 1.0:
                            viewModel.check()
                            withAnimation {
                                viewModel.touchState = .finished
                            }
                        case .updating(let location, let touchDownTime, _):
                            let timeInterval = Date().timeIntervalSince(touchDownTime)
                            let progress = max(0.0, min(1.0, timeInterval / ReminderViewModel.touchTimeInterval))
                            viewModel.touchState = .updating(
                                location: location,
                                touchDownTime: touchDownTime,
                                progress: progress
                            )
                        case .idle, .finished: break
                        }
                    }
                    .animation(nil, value: viewModel.touchState)
                    .transition(
                        .asymmetric(insertion: .opacity, removal: .opacity)
                            .animation(.easeOut(duration: 0.2))
                    )
                    .zIndex(1)
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0.0)
                .onChanged { value in
                    let location = CGPoint(
                        x: value.startLocation.x + value.translation.width,
                        y: value.startLocation.y + value.translation.height
                    )
                    switch viewModel.touchState {
                    case .idle:
                        viewModel.touchState = .updating(
                            location: location,
                            touchDownTime: Date(),
                            progress: 0.0
                        )
                    case .updating(_, let touchDownTime, let progress):
                        viewModel.touchState = .updating(
                            location: location,
                            touchDownTime: touchDownTime,
                            progress: progress
                        )
                    case .finished:
                        break
                    }
                }
                .onEnded { _ in
                    withAnimation {
                        viewModel.touchState = .idle
                    }
                }
        )
    }
}

private extension ReminderView {
    static let progressViewSize: CGFloat = 75.0

    struct ProgressView: View {
        let progress: CGFloat

        var body: some View {
            Circle()
                .trim(from: 0.0, to: max(0.0, min(1.0, progress)))
                .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .square, lineJoin: .bevel))
                .foregroundColor(.secondary.opacity(0.5))
        }
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView(viewModel: ReminderViewModel())
    }
}

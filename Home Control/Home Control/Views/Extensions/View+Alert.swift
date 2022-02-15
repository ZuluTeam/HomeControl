//
//  View+Alert.swift
//  Home Control
//
//  Created by Konstantin Zyrianov on 2022-02-15.
//

import Foundation
import Combine
import SwiftUI

extension View {
    func alert<AlertData, ActionView: View, MessageView: View>(
        title: String,
        isPresented: CurrentValueSubject<Bool, Never>,
        data: CurrentValueSubject<AlertData?, Never>,
        actions: @escaping (AlertData) -> ActionView,
        message: @escaping (AlertData) -> MessageView
    ) -> some View {
        modifier(
            AlertModifier(
                viewModel: AlertWrapperViewModel(
                    title: title,
                    isPresented: isPresented,
                    data: data),
                actions: actions,
                message: message
            )
        )
    }
}

private struct AlertModifier<AlertData, ActionView: View, MessageView: View>: ViewModifier {
    let viewModel: AlertWrapperViewModel<AlertData>
    @ViewBuilder let actions: (AlertData) -> ActionView
    @ViewBuilder let message: (AlertData) -> MessageView

    func body(content: Content) -> some View {
        AlertWrapperView(viewModel: viewModel, actions: actions, message: message, content: { content })
    }
}

private struct AlertWrapperView<Content: View, AlertData, ActionView: View, MessageView: View>: View {
    @ObservedObject var viewModel: AlertWrapperViewModel<AlertData>

    @ViewBuilder let actions: (AlertData) -> ActionView
    @ViewBuilder let message: (AlertData) -> MessageView

    @ViewBuilder let content: () -> Content

    var body: some View {
        content().alert(
            viewModel.title,
            isPresented: $viewModel.isPresented,
            presenting: viewModel.data,
            actions: actions,
            message: message
        )
    }
}

private final class AlertWrapperViewModel<AlertData>: ObservableObject {
    let title: String
    @Published var isPresented: Bool = false
    @Published private(set) var data: AlertData? = nil

    private var cancellables: Set<AnyCancellable> = []

    init(
        title: String,
        isPresented: CurrentValueSubject<Bool, Never>,
        data: CurrentValueSubject<AlertData?, Never>
    ) {
        self.title = title

        isPresented.sink { [unowned self] in self.isPresented = $0 }.store(in: &cancellables)
        data.sink { [unowned self] in self.data = $0 }.store(in: &cancellables)
    }
}

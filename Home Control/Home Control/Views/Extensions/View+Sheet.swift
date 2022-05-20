//
//  View+Sheet.swift
//  Home Control
//
//  Created by Konstantin Zyrianov on 2022-02-15.
//

import Foundation
import Combine
import SwiftUI

extension View {
    func sheet<PresentingContent: View>(
        isPresented: CurrentValueSubject<Bool, Never>,
        onDismiss: (() -> Void)? = nil,
        content: @escaping () -> PresentingContent
    ) -> some View {
        modifier(
            SheetModifier(
                viewModel: SheetWrapperViewModel(
                    isPresented: isPresented
                ),
                onDismiss: onDismiss,
                presentingContent: content
            )
        )
    }
}

private struct SheetModifier<PresentingContent: View>: ViewModifier {
    let viewModel: SheetWrapperViewModel
    let onDismiss: (() -> Void)?
    let presentingContent: (() -> PresentingContent)

    func body(content: Content) -> some View {
        SheetWrapperView(
            viewModel: viewModel,
            onDismiss: onDismiss,
            content: { content },
            presentingContent: presentingContent
        )
    }
}

private struct SheetWrapperView<Content: View, PresentingContent: View>: View {
    @ObservedObject var viewModel: SheetWrapperViewModel

    let onDismiss: (() -> Void)?
    @ViewBuilder let content: () -> Content
    @ViewBuilder let presentingContent: () -> PresentingContent

    var body: some View {
        content()
            .sheet(
                isPresented: $viewModel.isPresented,
                onDismiss: onDismiss,
                content: presentingContent
            )
    }
}

private final class SheetWrapperViewModel: ObservableObject {
    @Published var isPresented: Bool = false

    private var cancellables: Set<AnyCancellable> = []

    init(isPresented: CurrentValueSubject<Bool, Never>) {
        isPresented.sink { [unowned self] in self.isPresented = $0 }.store(in: &cancellables)
    }
}

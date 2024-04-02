//
//  ThrowingView.swift
//  Io
//
//  Created by Carson Gross on 4/2/24.
//

import SwiftUI

struct ThrowingView<Content, Label, Description>: View where Content: View, Label : View, Description : View {
    @ViewBuilder let content: Content
    @ViewBuilder let label: () -> Label
    @ViewBuilder let description: () -> Description
    @ViewBuilder let operation: @Sendable () async throws -> Void
    
    @State private var showErrorState = false
    
    /// Creates an interface, consisting of a label and additional content, that you
    /// display when the content of your app is unavailable to users. When the content
    /// is available, it displays the default content.
    ///
    /// - Parameters:
    ///   - content: The content that is displayed without and error.
    ///   - label: The label that describes the view.
    ///   - description: The view that describes the interface.
    ///   - operation: The operation to perform in `onAppear` and retried when the button is pressed.
    init(
        @ViewBuilder _ content: @escaping () -> Content,
        @ViewBuilder label: @escaping () -> Label,
        @ViewBuilder description: @escaping () -> Description = { EmptyView() },
        operation: @escaping @Sendable () async throws -> Void
    ) {
        self.content = content()
        self.label = label
        self.description = description
        self.operation = operation
    }
    
    var body: some View {
        if showErrorState {
            ContentUnavailableView(label: label, description: description) {
                Button("Retry", action: doOperation)
                    .padding(6)
                    .foregroundStyle(.secondary)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(.secondary)
                    )
            }
        } else {
            content
                .onAppear(perform: doOperation)
        }
    }
    
    func doOperation() {
        Task {
            do {
                try await operation()
                showErrorState = false
            } catch {
                print(error.localizedDescription)
                showErrorState = true
            }
        }
    }
}

#Preview {
    enum PreviewError: Error {
        case error
    }
    
    return ThrowingView {
        Text("Success")
    } label: {
        Text("Error")
    } description: {
        Text("There was an error loading this page")
    } operation: {
        throw PreviewError.error
    }
}

//
//  BrowseNavigationStack.swift
//  Io
//
//  Created by Carson Gross on 3/31/24.
//

import SwiftUI
import MusicKit

struct BrowseNavigationStack: View {
    @State private var model = BrowseModel()
    
    var body: some View {
        NavigationStack {
            ThrowingView {
                BrowseGridView()
                    .environment(model)
                    .navigationTitle("Browse")
            } label: {
                Text("Error")
            } description: {
                Text("There was an issue loading data.")
            } operation: {
                try await model.getRecommendations()
            }
        }
    }
}

#Preview {
    BrowseNavigationStack()
}

//
//  BrowseNavigationStack.swift
//  Io
//
//  Created by Carson Gross on 3/31/24.
//

import SwiftUI
import MusicKit

struct BrowseNavigationStack: View, @unchecked Sendable {
    @State private var recommendations = MusicItemCollection<MusicPersonalRecommendation>()
    
    var body: some View {
        NavigationStack {
            BrowseGridView(recommendations: recommendations)
                .navigationTitle("Browse")
        }
        .throwingView {
            Text("Error")
        } description: {
            Text("There was an error loading data.")
        } operation: {
            try await getRecommendations()
        }
    }
    
    @MainActor
    @Sendable
    func getRecommendations() async throws {
        var request = MusicPersonalRecommendationsRequest()
        request.limit = 10
        let response = try await request.response()
        recommendations = response.recommendations
    }
}

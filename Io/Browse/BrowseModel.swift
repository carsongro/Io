//
//  BrowseModel.swift
//  Io
//
//  Created by Carson Gross on 3/31/24.
//

import Foundation
import MusicKit

@Observable
final class BrowseModel: @unchecked Sendable {
    private(set) var recommendations = MusicItemCollection<MusicPersonalRecommendation>()
    
    @MainActor
    @Sendable
    func getRecommendations() async throws {
        var request = MusicPersonalRecommendationsRequest()
        request.limit = 10
        let response = try await request.response()
        recommendations = response.recommendations
    }
}

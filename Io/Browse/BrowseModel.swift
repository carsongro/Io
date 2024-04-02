//
//  BrowseModel.swift
//  Io
//
//  Created by Carson Gross on 3/31/24.
//

import Foundation
import MusicKit

@Observable
final class BrowseModel {
    var recommendations = MusicItemCollection<MusicPersonalRecommendation>()
    
    init() {
        Task {
            do {
                recommendations = try await getRecommendations()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    func getRecommendations() async throws -> MusicItemCollection<MusicPersonalRecommendation> {
        var request = MusicPersonalRecommendationsRequest()
        request.limit = 10
        let response = try await request.response()
        return response.recommendations
    }
}

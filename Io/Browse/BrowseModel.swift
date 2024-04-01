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
    private var playlists = MusicItemCollection<Playlist>()
    private var albums = MusicItemCollection<Album>()
    private var recommendations = MusicItemCollection<MusicPersonalRecommendation>()
    
    enum BrowseSection: Identifiable, Hashable {
        var id: Self { self }
        
//        case playlists(playlists: MusicItemCollection<Playlist>)
//        case albums(albums: MusicItemCollection<Album>)
//        
//        var title: String {
//            switch self {
//            case .playlists:
//                "Playlists"
//            case .albums:
//                "Albums"
//            }
//        }
        case items(items: MusicItemCollection<MusicPersonalRecommendation.Item>)
        var title: String {
            switch self {
            case .items:
                "Recommendations"
            }
        }
    }
    
    var sections = [BrowseSection]()
    
    init() {
        Task {
            await fetchData()
        }
    }
    
    @MainActor
    func fetchData() async {
        do {
            let request = MusicPersonalRecommendationsRequest()
            let response = try await request.response()
            recommendations = MusicItemCollection<MusicPersonalRecommendation>(response.recommendations)
            recommendations.forEach { rec in
                albums += rec.albums
                playlists += rec.playlists
            }
            if let items = recommendations.first?.items {
                sections.append(
                    contentsOf: [
                        .items(items: items)
                    ]
                )
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

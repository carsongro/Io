//
//  SearchModel.swift
//  Io
//
//  Created by Carson Gross on 4/3/24.
//

import Foundation
import MusicKit

//MARK: - READ THIS
///MANY METHODS ARE COMMENTED OUT BECAUSE `CatalogFilterIdentifyingItem` PROTOCOL IS NOT PUBLIC :( I HOPE IT PUBLIC SOMEDAY 👍
//MARK: - READ THIS

@Observable
final class SearchModel {
    var topResults = MusicItemCollection<MusicBrowseItem>()
//    var recentlyViewedResults = MusicItemCollection<MusicBrowseItem>()
    var searchTerm = "" {
        didSet {
            requestUpdatedSearchResults(for: searchTerm)
        }
    }
    
//    private let recentlyViewedResultsIdentifiersKey = "recently-viewed-results-identifiers"
//    private let maximumNumberOfRecentlyViewedResults = 10

    /// Retrieves recently viewed results identifiers from `UserDefaults`.
//    private var recentlyViewedResultsIDs: [MusicItemID] {
//        get {
//            let rawRecentlyViewedResultIdentifiers = UserDefaults.standard.array(forKey: recentlyViewedResultsIdentifiersKey) ?? []
//            let recentlyViewedResultIDs = rawRecentlyViewedResultIdentifiers.compactMap { identifier -> MusicItemID? in
//                var itemID: MusicItemID?
//                if let stringIdentifier = identifier as? String {
//                    itemID = MusicItemID(stringIdentifier)
//                }
//                return itemID
//            }
//            return recentlyViewedResultIDs
//        }
//        set {
//            UserDefaults.standard.set(newValue.map(\.rawValue), forKey: recentlyViewedResultsIdentifiersKey)
//            loadRecentlyViewedResults()
//        }
//    }
    
    /// Clears recently viewed result identifiers from `UserDefaults`.
//    func reset() {
//        self.recentlyViewedResultsIDs = []
//    }
    
    /// Adds an result to the viewed result identifiers in `UserDefaults`.
//    func update(with recentlyViewedResult: MusicBrowseItem) {
//        var recentlyViewedResultsIDs = self.recentlyViewedResultsIDs
//        if let index = recentlyViewedResultsIDs.firstIndex(of: recentlyViewedResult.id) {
//            recentlyViewedResultsIDs.remove(at: index)
//        }
//        recentlyViewedResultsIDs.insert(recentlyViewedResult.id, at: 0)
//        while recentlyViewedResultsIDs.count > maximumNumberOfRecentlyViewedResults {
//            recentlyViewedResultsIDs.removeLast()
//        }
//        self.recentlyViewedResultsIDs = recentlyViewedResultsIDs
//    }
    
    /// Updates the recently viewed results when MusicKit authorization status changes.
//    func loadRecentlyViewedResults() {
//        let recentlyViewedResultsIDs = self.recentlyViewedResultsIDs
//        if recentlyViewedResultsIDs.isEmpty {
//            self.recentlyViewedResults = []
//        } else {
//            Task {
//                do {
//                    let resultsRequest = MusicCatalogResourceRequest<MusicBrowseItem>(matching: \.id, memberOf: recentlyViewedResultsIDs)
//                    let resultsResponse = try await resultsRequest.response()
//                    await self.updateRecentlyViewedResults(resultsResponse.items)
//                } catch {
//                    print("Failed to load results for recently viewed album IDs: \(recentlyViewedResultsIDs)")
//                }
//            }
//        }
//    }
    
    /// Safely changes `recentlyViewedResults` on the main thread.
//    @MainActor
//    private func updateRecentlyViewedResults(_ recentlyViewedResults: MusicItemCollection<MusicBrowseItem>) {
//        self.recentlyViewedResults = recentlyViewedResults
//    }
    
    /// Safely resets the `results` property on the main thread.
    @MainActor
    func resetTopResults() {
        self.topResults = []
    }
    
    /// Safely updates the `results` property on the main thread.
    @MainActor
    private func apply(_ searchResponse: MusicCatalogSearchResponse, for searchTerm: String) {
        if self.searchTerm == searchTerm {
            self.topResults = MusicItemCollection<MusicBrowseItem>(searchResponse.topResults.compactMap {
                switch $0 {
                case .album(let album): MusicBrowseItem.album(album)
                case .playlist(let playlist): MusicBrowseItem.playlist(playlist)
                case .artist(let artist): MusicBrowseItem.artist(artist)
                case .song(let song): MusicBrowseItem.song(song)
                default: nil
                }
            })
        }
    }
    
    /// Makes a new search request to MusicKit when the current search term changes.
    func requestUpdatedSearchResults(for searchTerm: String) {
        Task {
            if searchTerm.isEmpty {
                await resetTopResults()
            } else {
                do {
                    // Issue a catalog search request for results matching the search term.
                    var searchRequest = MusicCatalogSearchRequest(
                        term: searchTerm,
                        types: [
                            Album.self,
                            Song.self,
                            Artist.self
                        ]
                    )
                    searchRequest.includeTopResults = true
                    searchRequest.limit = 10
                    let searchResponse = try await searchRequest.response()
                    
                    // Update the user interface with the search response.
                    await apply(searchResponse, for: searchTerm)
                } catch {
                    print("Search request failed with error: \(error).")
                    await resetTopResults()
                }
            }
        }
    }
}

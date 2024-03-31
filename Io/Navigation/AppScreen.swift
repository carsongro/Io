//
//  AppScreen.swift
//  Io
//
//  Created by Carson Gross on 3/29/24.
//

import SwiftUI
import MusicKit

enum AppScreen: Codable, Hashable, Identifiable {
    case browse
    case search
    case library
    case playlist(Playlist)
    
    var id: AppScreen { self }
}

extension AppScreen {
    @ViewBuilder
    var label: some View {
        switch self {
        case .browse:
            Label("Browse", systemImage: "square.grid.2x2.fill")
                .imageScale(.large)
        case .search:
            Label("Search", systemImage: "magnifyingglass")
                .imageScale(.large)
        case .library:
            Label("Library", systemImage: "books.vertical.fill")
                .imageScale(.large)
        case .playlist(let playlist):
            PlaylistRow(playlist: playlist)
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .browse:
            BrowseNavigationStack()
        case .search:
            SearchNavigationStack()
        case .library:
            LibraryNavigationStack()
        case .playlist(let playlist):
            PlaylistDetailView(playlist: playlist)
        }
    }
}

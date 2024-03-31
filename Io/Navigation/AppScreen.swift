//
//  AppScreen.swift
//  Io
//
//  Created by Carson Gross on 3/29/24.
//

import SwiftUI
import MusicKit

enum AppScreen: Codable, Hashable, Identifiable {
    case home
    case search
    case playlist(Playlist)
    
    var id: AppScreen { self }
}

extension AppScreen {
    @ViewBuilder
    var label: some View {
        switch self {
        case .home:
            Label("Home", systemImage: "music.note.house.fill")
                .imageScale(.large)
        case .search:
            Label("Search", systemImage: "magnifyingglass")
                .imageScale(.large)
        case .playlist(let playlist):
            PlaylistRow(playlist: playlist)
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .home:
            HomeNavigationStack()
        case .search:
            SearchNavigationStack()
        case .playlist(let playlist):
            PlaylistDetailView(playlist: playlist)
        }
    }
}

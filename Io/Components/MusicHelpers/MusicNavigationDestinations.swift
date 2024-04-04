//
//  MusicNavigationDestinations.swift
//  Io
//
//  Created by Carson Gross on 4/3/24.
//

import SwiftUI
import MusicKit

struct NavigationDestinations: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: Playlist.self, destination: PlaylistDetailView.init)
            .navigationDestination(for: Album.self, destination: AlbumDetailView.init)
            .navigationDestination(for: MusicPersonalRecommendation.Item.self) { item in
                switch item {
                case .playlist(let playlist):
                    PlaylistDetailView(playlist: playlist)
                case .album(let album):
                    AlbumDetailView(album: album)
                default:
                    EmptyView()
                }
            }
    }
}

extension View {
    func musicNavigationDestinations() -> some View {
        self
            .modifier(NavigationDestinations())
    }
}

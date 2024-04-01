//
//  MusicItemCollectionDetailModifier.swift
//  Io
//
//  Created by Carson Gross on 3/31/24.
//

import SwiftUI
import MusicKit

struct PlaylistWith: ViewModifier {
    @Binding var detailedPlaylist: Playlist?
    var playlist: Playlist
    
    let properties: [PartialMusicAsyncProperty<Playlist>]
    
    init(_ properties: [PartialMusicAsyncProperty<Playlist>], from playlist: Playlist, detailedPlaylist: Binding<Optional<Playlist>>) {
        _detailedPlaylist = detailedPlaylist
        self.playlist = playlist
        self.properties = properties
    }
    
    func body(content: Content) -> some View {
        content
            .task { await getDetailedPlaylist() }
    }
    
    private func getDetailedPlaylist() async {
        do {
            let detailedPlaylist = try await playlist.with(properties)
            
            withAnimation {
                self.detailedPlaylist = detailedPlaylist
            }
        } catch {
            print("❌ Error fetching detailed playlist: \(error.localizedDescription)")
        }
    }
}

extension View {
    func playlistWith(_ properties: PartialMusicAsyncProperty<Playlist>..., from playlist: Playlist, detailedPlaylist: Binding<Optional<Playlist>>) -> some View {
        modifier(PlaylistWith(properties, from: playlist, detailedPlaylist: detailedPlaylist))
    }
}

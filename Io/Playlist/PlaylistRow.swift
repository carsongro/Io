//
//  PlaylistRow.swift
//  Io
//
//  Created by Carson Gross on 3/31/24.
//

import SwiftUI
import MusicKit

struct PlaylistRow: View {
    var playlist: Playlist
    
    var body: some View {
        NavigationLink(value: playlist) {
            MusicItemCell(
                artwork: playlist.artwork,
                title: playlist.name,
                subtitle: playlist.curatorName ?? ""
            )
        }
    }
}

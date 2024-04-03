//
//  SongCell.swift
//  Io
//
//  Created by Carson Gross on 4/3/24.
//

import MusicKit
import SwiftUI

/// `SongCell` is a view to use in a SwiftUI `List` to represent a `Song`.
struct SongCell: View {
    
    init(_ song: Song) {
        self.song = song
    }
    
    let song: Song
    
    private var subtitle: String {
        "Song · " + song.artistName
    }
    
    var body: some View {
        MusicItemCell(
            artwork: song.artwork,
            title: song.title,
            subtitle: subtitle
        )
        .frame(minHeight: 50)
    }
}

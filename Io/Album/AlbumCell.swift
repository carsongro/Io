//
//  AlbumCell.swift
//  Io
//
//  Created by Carson Gross on 4/3/24.
//

import MusicKit
import SwiftUI

/// `AlbumCell` is a view to use in a SwiftUI `List` to represent an `Album`.
struct AlbumCell: View {
    
    init(_ album: Album, _ didSelect: @escaping () -> Void) {
        self.album = album
        self.didSelect = didSelect
    }
    
    let album: Album
    let didSelect: () -> Void
       
    var body: some View {
        Button(action: didSelect) {
            MusicItemCell(
                artwork: album.artwork,
                title: album.title,
                subtitle: "Album · " + album.artistName
            )
        }
        .buttonStyle(.plain)
    }
}

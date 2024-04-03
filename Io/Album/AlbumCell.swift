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
    
    init(_ album: Album) {
        self.album = album
    }
    
    let album: Album
       
    var body: some View {
        MusicItemCell(
            artwork: album.artwork,
            title: album.title,
            subtitle: "Album · " + album.artistName
        )
    }
}

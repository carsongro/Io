//
//  AlbumsHScrollView.swift
//  Io
//
//  Created by Carson Gross on 4/3/24.
//

import SwiftUI
import MusicKit

struct AlbumsHScrollView: View {
    let albums: MusicItemCollection<Album>
    
    init(_ albums: MusicItemCollection<Album>) {
        self.albums = albums
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(albums) { album in
                    AlbumIconCell(album)
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned(limitBehavior: .never))
        .contentMargins(20, for: .scrollContent)
    }
}

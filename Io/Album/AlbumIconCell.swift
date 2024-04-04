//
//  AlbumIconCell.swift
//  Io
//
//  Created by Carson Gross on 4/3/24.
//

import SwiftUI
import MusicKit

struct AlbumIconCell: View {
    var album: Album
    
    init(_ album: Album) {
        self.album = album
    }
    
    var body: some View {
        NavigationLink(value: album) {
            VStack(alignment: .leading) {
                if let artwork = album.artwork {
                    ArtworkImage(artwork, width: 170)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
                
                Text(album.title)
                    .lineLimit(1)
            }
        }
        .buttonStyle(.plain)
    }
}

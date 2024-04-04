//
//  ArtistLatestReleaseCell.swift
//  Io
//
//  Created by Carson Gross on 4/3/24.
//

import SwiftUI
import MusicKit

struct ArtistLatestReleaseCell: View {
    var album: Album
    
    @State private var selectedItem: MusicBrowseItem?
    
    init(_ album: Album) {
        self.album = album
    }
    
    var body: some View {
        Button {
            selectedItem = MusicBrowseItem.album(album)
        } label: {
            HStack {
                if let artwork = album.artwork {
                    ArtworkImage(artwork, width: 100)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
                
                VStack(alignment: .leading) {
                    if let releaseDate = album.releaseDate?.formatted(date: .abbreviated, time: .omitted) {
                        Text(releaseDate)
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                    }
                    
                    Text(album.title)
                }
            }
        }
        .buttonStyle(.plain)
        .fullScreenCover(item: $selectedItem) { item in
            BrowseHScrollView(items: [item], selectedItemID: item.id)
                .presentationBackground(.thickMaterial)
        }
    }
}

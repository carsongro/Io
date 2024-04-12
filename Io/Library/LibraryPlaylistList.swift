//
//  LibraryPlaylistList.swift
//  Io
//
//  Created by Carson Gross on 4/10/24.
//

import SwiftUI
import MusicKit

struct LibraryPlaylistList: View {
    var items: MusicItemCollection<MusicBrowseItem>
    
    @State private var selectedItem: MusicBrowseItem?
    
    var body: some View {
        List(items) { item in
            Button {
                selectedItem = item
            } label: {
                MusicItemCell(
                    artwork: item.artwork,
                    title: item.title,
                    subtitle: item.subtitle
                )
            }
            .buttonStyle(.plain)
        }
        .fullScreenCover(item: $selectedItem) { item in
            BrowseHScrollView(items: items, selectedItemID: item.id)
                .presentationBackground(.thickMaterial)
        }
    }
}

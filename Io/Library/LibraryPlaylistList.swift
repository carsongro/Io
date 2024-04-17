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
                    subtitle: item.subtitle,
                    width: 65
                )
            }
            .buttonStyle(.plain)
            .listRowInsets(
                EdgeInsets(
                    top: 5,
                    leading: 20,
                    bottom: 5,
                    trailing: 20
                )
            )
        }
        .listStyle(.plain)
        .fullScreenCover(item: $selectedItem) { item in
            BrowseHScrollView(items: items, selectedItemID: item.id)
                .presentationBackground(.thickMaterial)
        }
    }
}

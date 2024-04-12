//
//  LibraryNavigationStack.swift
//  Io
//
//  Created by Carson Gross on 3/31/24.
//

import SwiftUI
import MusicKit

struct LibraryNavigationStack: View {
    @State private var model = MusicLibraryManager.shared
    
    private var items: MusicItemCollection<MusicBrowseItem> {
        MusicItemCollection<MusicBrowseItem>(model.playlists.map { MusicBrowseItem.playlist($0) })
    }
    
    var body: some View {
        NavigationStack {
            LibraryPlaylistList(items: items)
                .navigationTitle("Library")
                .throwingView {
                    Text("Error")
                } description: {
                    Text("There was an error fetching your library.")
                } operation: {
                    try await model.fetchLibraryPlaylists()
                }
        }
    }
}

#Preview {
    LibraryNavigationStack()
}

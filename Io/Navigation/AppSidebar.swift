//
//  AppSidebar.swift
//  Io
//
//  Created by Carson Gross on 3/29/24.
//

import SwiftUI

struct AppSidebar: View {
    @Environment(Navigator.self) private var navigator
    @Environment(MusicLibraryManager.self) private var musicLibraryManager
    
    var body: some View {
        @Bindable var navigator = navigator
        List(selection: $navigator.selectedScreen) {
            Section {
                NavigationLink(value: AppScreen.home) {
                    AppScreen.home.label
                }
                
                NavigationLink(value: AppScreen.search) {
                    AppScreen.search.label
                }
            }
            
            Section("Library") {
                //TODO: ADD GRID VIEW
                ForEach(musicLibraryManager.playlists) { playlist in
                    NavigationLink(value: AppScreen.playlist(playlist)) {
                        PlaylistRow(playlist: playlist)
                    }
                    .padding(.vertical, -6)
                }
            }
        }
    }
}

#Preview {
    AppSidebar()
        .environment(Navigator.shared)
        .environment(MusicLibraryManager.shared)
}

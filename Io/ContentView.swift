//
//  ContentView.swift
//  Io
//
//  Created by Carson Gross on 3/31/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    
    @State private var navigator = Navigator.shared
    
    var body: some View {
        Group {
            if navigator.isWelcomeViewPresented {
                WelcomeView(musicAuthorizationStatus: $navigator.musicAuthorizationStatus)
            } else {
                if prefersTabNavigation {
                    AppTabView()
                } else {
                    VStack {
                        NavigationSplitView {
                            AppSidebar()
                                .navigationSplitViewColumnWidth(ideal: 250, max: 500)
                        } detail: {
                            AppDetailColumn(screen: navigator.selectedScreen)
                        }
                        
                        PlayerView()
                    }
                }
            }
        }
        .environment(navigator)
        .environment(MusicLibraryManager.shared)
    }
}

#Preview {
    ContentView()
}

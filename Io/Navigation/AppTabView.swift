//
//  AppTabView.swift
//  Io
//
//  Created by Carson Gross on 3/31/24.
//

import SwiftUI

struct AppTabView: View {
    @Environment(Navigator.self) private var navigator
    
    var body: some View {
        @Bindable var navigator = navigator
        TabView(selection: $navigator.selectedScreen) {
            AppScreen.browse.destination
                .tag(AppScreen.browse)
                .tabItem { AppScreen.browse.label }
            
            AppScreen.library.destination
                .tag(AppScreen.library)
                .tabItem { AppScreen.library.label }
            
            AppScreen.search.destination
                .tag(AppScreen.search)
                .tabItem { AppScreen.search.label }
            
        }
    }
}

#Preview {
    AppTabView()
        .environment(Navigator.shared)
}

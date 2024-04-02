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
            /// For some reason using AppScreen.browse.destination when the BrowseNavigationStack declares @State private var model = BrowseModel()
            /// causes all tabs to be unselectedable, so either removing the model from BrowseNavigationStack or using BrowseNavigationStack() here
            /// instead of AppScreen.browse.destination fixes it. Doing it this way is easier than removing the model.
            BrowseNavigationStack()
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

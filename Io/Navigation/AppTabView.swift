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
            AppScreen.home.destination
                .tabItem { AppScreen.home.label }
            
            AppScreen.search.destination
                .tabItem { AppScreen.search.label }
            
            AppScreen.library.destination
                .tabItem { AppScreen.library.label }
        }
    }
}

#Preview {
    AppTabView()
        .environment(Navigator.shared)
}

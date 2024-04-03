//
//  SearchNavigationStack.swift
//  Io
//
//  Created by Carson Gross on 3/31/24.
//

import SwiftUI
import MusicKit

struct SearchNavigationStack: View {
    @State private var model = SearchModel()
    
    @State private var selectedResult: MusicBrowseItem?
    
    var body: some View {
        @Bindable var model = model
        NavigationStack {
            VStack {
                searchResultsList
                    .animation(.default, value: model.topResults)
                
                Spacer()
            }
            .onAppear(perform: model.loadRecentlyViewedResults)
            .onChange(of: model.searchTerm) { _, _ in
                model.requestUpdatedSearchResults(for: model.searchTerm)
            }
            .navigationTitle("Search")
            .searchable(text: $model.searchTerm, prompt: "Albums, Songs, and Artists")
            .musicNavigationDestinations()
            .fullScreenCover(item: $selectedResult) { item in
                BrowseHScrollView(items: model.topResults, selectedItemID: item.id)
                    .presentationBackground(.thickMaterial)
            }
        }
    }
    
    @State private var showingClearRecentConfirmation = false
    
    private var searchResultsList: some View {
        List {
            Section {
                clearRecent
            }
            .listRowSeparator(.hidden, edges: .top)
            
            Section {
                ForEach(model.topResults.isEmpty ? model.recentlyViewedResults : model.topResults) { result in
                    switch result {
                    case .album(let album):
                        AlbumCell(album) {
                            selectedResult = MusicBrowseItem.album(album)
                        }
                    case .artist(let artist):
                        ArtistCell(artist: artist) {
                            selectedResult = MusicBrowseItem.artist(artist)
                        }
                    case .song(let song):
                        SongCell(song) {
                            selectedResult = MusicBrowseItem.song(song)
                        }
                    default: 
                        EmptyView() // TODO: Add more cases
                    }
                }
            }
        }
        .listStyle(.plain)
        .contentMargins(.bottom, 65, for: .scrollContent)
    }
    
    @ViewBuilder
    private var clearRecent: some View {
        if model.topResults.isEmpty && !model.recentlyViewedResults.isEmpty {
            HStack {
                Text("Recently Searched")
                    .fontWeight(.bold)
                
                Spacer()
                
                Button("Clear") {
                    showingClearRecentConfirmation = true
                }
                .fontWeight(.semibold)
                .foregroundStyle(Color.accentColor)
            }
            .font(.callout)
            .confirmationDialog(
                "Are you sure you want to clear your recent searches?",
                isPresented: $showingClearRecentConfirmation
            ) {
                Button("Clear", role: .destructive) {
                    withAnimation {
                        showingClearRecentConfirmation = false
                        model.reset()
                        model.searchTerm = ""
                    }
                }
            }
        }
    }
}

#Preview {
    SearchNavigationStack()
}

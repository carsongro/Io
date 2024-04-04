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
            .navigationTitle("Search")
            .searchable(text: $model.searchTerm, prompt: "Albums, Songs, and Artists")
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
                ForEach(model.topResults) { result in
                    Button {
                        switch result {
                        case .song(let song):
                            // TODO: Play song
                            break
                        default:
                            selectedResult = result
                        }
                    } label: {
                        Group {
                            switch result {
                            case .album(let album):
                                AlbumCell(album)
                            case .artist(let artist):
                                ArtistCell(artist: artist)
                            case .song(let song):
                                SongCell(song)
                            default:
                                EmptyView() // TODO: Add more cases
                            }
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .listStyle(.plain)
        .contentMargins(.bottom, 65, for: .scrollContent)
    }
    
//    @ViewBuilder
//    private var clearRecent: some View {
//        if model.topResults.isEmpty && !model.recentlyViewedResults.isEmpty {
//            HStack {
//                Text("Recently Searched")
//                    .fontWeight(.bold)
//                
//                Spacer()
//                
//                Button("Clear") {
//                    showingClearRecentConfirmation = true
//                }
//                .fontWeight(.semibold)
//                .foregroundStyle(Color.accentColor)
//            }
//            .font(.callout)
//            .confirmationDialog(
//                "Are you sure you want to clear your recent searches?",
//                isPresented: $showingClearRecentConfirmation
//            ) {
//                Button("Clear", role: .destructive) {
//                    withAnimation {
//                        showingClearRecentConfirmation = false
//                        model.reset()
//                        model.searchTerm = ""
//                    }
//                }
//            }
//        }
//    }
}

#Preview {
    SearchNavigationStack()
}

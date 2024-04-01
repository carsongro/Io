//
//  PlaylistDetailView.swift
//  Io
//
//  Created by Carson Gross on 3/31/24.
//

import SwiftUI
import MusicKit

struct PlaylistDetailView: View {
    var playlist: Playlist
    
    @State private var detailedPlaylist: Playlist?
    
    var body: some View {
        Group {
            if let detailedPlaylist {
                List {
                    Section {
                        VStack(spacing: 10) {
                            CollectionHeader(
                                artwork: detailedPlaylist.artwork,
                                title: detailedPlaylist.name,
                                ownerName: detailedPlaylist.curatorName,
                                description: detailedPlaylist.description,
                                itemCount: detailedPlaylist.tracks?.count
                            )
                            
                            CollectionPlayButton(playlist)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .listRowSeparator(.hidden, edges: .top)
                    .background(GeometryReader { Color.clear.preference(key: ScrollOffsetPreferenceKey.self, value: -$0.frame(in: .named("scroll")).origin.y) })
                    
                    Section {
                        TrackListView(showArtwork: true, tracks: detailedPlaylist.tracks)
                    }
                }
                .listSectionSpacing(10)
                .listStyle(.plain)
                .contentMargins(.bottom, 10, for: .scrollContent)
                .scrollIndicators(.hidden)
            } else {
                Color.clear
            }
        }
        .coordinateSpace(name: "scroll")
        .canOfferSubscription(for: playlist.id, messageIdentifier: .playMusic)
        .task { await getDetailedPlaylist() }
    }
    
    private func getDetailedPlaylist() async {
        do {
            detailedPlaylist = try await playlist.with([.tracks, .moreByCurator, .featuredArtists])
        } catch {
            print("❌ Error fetching detailed playlist: \(error.localizedDescription)")
        }
    }
}


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
    
    private let dismiss: (() -> Void)?
    
    init(
        playlist: Playlist,
        dismiss: (() -> Void)? = nil
    ) {
        self.playlist = playlist
        self.dismiss = dismiss
    }
    
    init(
        playlist: Playlist
    ) {
        self.playlist = playlist
        self.dismiss = nil
    }
    
    var body: some View {
        Group {
            if let detailedPlaylist {
                ScrollView {
                    VStack {
                        LazyVStack {
                            Color.clear
                                .frame(width: 1, height: 1)
                                .onAppear(perform: dismiss)
                        }
                        .offset(y: -100)
                        
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
                        
                        Section {
                            TrackListView(showArtwork: true, tracks: detailedPlaylist.tracks)
                        }
                    }
                }
                .listSectionSpacing(10)
                .listStyle(.plain)
                .contentMargins(.bottom, 10, for: .scrollContent)
                .scrollIndicators(.hidden)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                Color.clear
                    .frame(width: 320)
            }
        }
        .canOfferSubscription(for: playlist.id, messageIdentifier: .playMusic)
        .playlistWith(.tracks, .curator, from: playlist, detailedPlaylist: $detailedPlaylist)
    }
}


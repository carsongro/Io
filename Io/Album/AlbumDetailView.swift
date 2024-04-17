//
//  AlbumDetailView.swift
//  Io
//
//  Created by Carson Gross on 4/1/24.
//

import SwiftUI
import MusicKit

struct AlbumDetailView: View {
    var album: Album
    
    @State private var detailedAlbum: Album?
    
    private let dismiss: (() -> Void)?
    
    init(
        album: Album,
        dismiss: (() -> Void)? = nil
    ) {
        self.album = album
        self.dismiss = dismiss
    }
    
    init(
        album: Album
    ) {
        self.album = album
        self.dismiss = nil
    }
    
    var body: some View {
        Group {
            if let detailedAlbum {
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        dismissIndicator
                        
                        Section {
                            VStack(spacing: 10) {
                                CollectionHeader(
                                    artwork: detailedAlbum.artwork,
                                    title: detailedAlbum.title,
                                    ownerName: detailedAlbum.artistName,
                                    description: detailedAlbum.description,
                                    itemCount: detailedAlbum.tracks?.count
                                )
                                
                                CollectionPlayButton(album)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .listRowSeparator(.hidden, edges: .top)
                        
                        Section {
                            TrackListView(showArtwork: false, tracks: detailedAlbum.tracks)
                        }
                    }
                }
                .contentMargins(.bottom, 65, for: .scrollContent)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                Color.clear
                    .frame(width: 310)
            }
        }
        .canOfferSubscription(for: album.id, messageIdentifier: .playMusic)
        .animation(.default, value: detailedAlbum)
        .musicItemWith(.tracks, .artists, from: album, detailedItem: $detailedAlbum)
    }
    
    private var dismissIndicator: some View {
        LazyVStack {
            Color.clear
                .frame(width: 1, height: 1)
                .onAppear(perform: dismiss)
        }
        .offset(y: -100)
    }
}



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
                            TrackListView(tracks: detailedAlbum.tracks)
                                .hideArtwork()
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
        .itemWith(.tracks, .curator, from: album) { album in
            withAnimation {
                self.detailedAlbum = album
            }
        }
    }
}



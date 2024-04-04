//
//  ArtistDetailView.swift
//  Io
//
//  Created by Carson Gross on 4/3/24.
//

import SwiftUI
import MusicKit

struct ArtistDetailView: View {
    var artist: Artist
    @State private var detailedArtist: Artist?
    
    var dismiss: () -> Void
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                Group {
                    if let detailedArtist {
                        ScrollView(showsIndicators: false) {
                            VStack(alignment: .leading, spacing: 20) {
                                dismissIndicator
                                
                                header(width: proxy.frame(in: .global).width)
                                
                                if let latestRelease = detailedArtist.latestRelease {
                                    ArtistLatestReleaseCell(latestRelease)

                                }
                                
                                if let songs = detailedArtist.topSongs {
                                    VStack(alignment: .leading, spacing: 1) {
                                        Text("Top Songs")
                                            .font(.title2.bold())
                                            .foregroundStyle(.primary)
                                        
                                        SongGrid(songs)
                                    }
                                }
                                
                                if let albums = detailedArtist.albums {
                                    Text("Albums")
                                        .font(.title2.bold())
                                        .foregroundStyle(.primary)
                                    
                                    MusicItemCollectionMediumHScrollView(items: MusicItemCollection<MusicBrowseItem>(albums.map { MusicBrowseItem.album($0) })) { item in
                                        MediumMusicItemCell(artwork: item.artwork, title: item.title, subtitle: item.subtitle)
                                    }
                                }
                                
                                if let playlists = detailedArtist.playlists {
                                    Text("Artist Playlists")
                                        .font(.title2.bold())
                                        .foregroundStyle(.primary)
                                    
                                    MusicItemCollectionMediumHScrollView(items: MusicItemCollection<MusicBrowseItem>(playlists.map { MusicBrowseItem.playlist($0) })) { item in
                                        MediumMusicItemCell(artwork: item.artwork, title: item.title, subtitle: item.subtitle)
                                    }
                                }
                            }
                        }
                        .contentMargins(.bottom, 65, for: .scrollContent)
                    } else {
                        Color.clear
                    }
                }
                .musicItemWith(.featuredAlbums, .topSongs, .albums, .latestRelease, .playlists, from: artist, detailedItem: $detailedArtist)
            }
        }
    }
    
    @ViewBuilder
    private func header(width: CGFloat) -> some View {
        VStack(alignment: .leading) {
            Text(artist.name)
                .font(.largeTitle.bold())
            
            if let artwork = detailedArtist?.artwork {
                ArtworkImage(
                    artwork,
                    width: width,
                    height: width
                )
                .ignoresSafeArea()
            }
        }
    }
    
    private var dismissIndicator: some View {
        LazyVStack {
            Color.clear
                .frame(width: 1, height: 1)
                .onAppear(perform: dismiss)
        }
        .offset(y: -130)
    }
}


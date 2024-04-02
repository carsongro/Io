//
//  BrowseHScrollCardView.swift
//  Io
//
//  Created by Carson Gross on 3/31/24.
//

import SwiftUI
import MusicKit

struct BrowseHScrollCardView: View {
    @Environment(\.dismiss) private var dismiss
    
    let items: MusicItemCollection<MusicPersonalRecommendation.Item>
    let selectedItemID: MusicPersonalRecommendation.Item.ID?
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(items) { item in
                        Group {
                            switch item {
                            case .playlist(let playlist): PlaylistDetailView(playlist: playlist) { dismiss() }
                            case .album(let album): AlbumDetailView(album: album) { dismiss() }
                            default: EmptyView()
                            }
                        }
                        .containerRelativeFrame(.horizontal)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .id(item.id)
                        .scrollTransition { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1 : 0.6)
                                .scaleEffect(phase.isIdentity ? 1 : 0.9)
                                .blur(radius: phase.isIdentity ? 0 : 8)
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .contentMargins(20, for: .scrollContent)
            .listRowInsets(EdgeInsets())
            .ignoresSafeArea(edges: .bottom)
            .onAppear {
                proxy.scrollTo(selectedItemID)
            }
        }
    }
}

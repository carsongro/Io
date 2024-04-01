//
//  MusicItemCollectionHScrollView.swift
//  Io
//
//  Created by Carson Gross on 3/31/24.
//

import SwiftUI
import MusicKit

struct MusicItemCollectionHScrollView: View {
    var items: MusicItemCollection<MusicPersonalRecommendation.Item>
    
    @State private var selectedItem: MusicPersonalRecommendation.Item?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(items) { item in
                    Button {
                        selectedItem = item
                    } label: {
                        MediumMusicItemCell(
                            artwork: item.artwork,
                            title: item.title,
                            subtitle: item.subtitle
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .scrollTargetLayout()
        }
        .contentMargins(.horizontal, 16, for: .scrollContent)
        .scrollTargetBehavior(.viewAligned(limitBehavior: .never))
        .fullScreenCover(item: $selectedItem) { item in
            BrowseHScrollCardView(items: items, selectedItemID: item.id)
                .presentationBackground(.ultraThinMaterial)
        }
    }
}

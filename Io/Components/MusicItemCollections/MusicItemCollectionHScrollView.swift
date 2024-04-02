//
//  MusicItemCollectionHScrollView.swift
//  Io
//
//  Created by Carson Gross on 3/31/24.
//

import SwiftUI
import MusicKit

struct MusicItemCollectionHScrollView<Cell: View>: View {
    
    var items: MusicItemCollection<MusicPersonalRecommendation.Item>
    @ViewBuilder var cell: (_ item: MusicPersonalRecommendation.Item) -> Cell
    
    @State private var selectedItem: MusicPersonalRecommendation.Item?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(items) { item in
                    Button {
                        selectedItem = item
                    } label: {
                        cell(item)
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
                .presentationBackground(.thickMaterial)
        }
    }
}

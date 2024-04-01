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
    
    @State private var selectedItemID: MusicPersonalRecommendation.Item.ID?
    
    init(items: MusicItemCollection<MusicPersonalRecommendation.Item>, selectedItemID: MusicPersonalRecommendation.Item.ID?) {
        self.items = items
        self.selectedItemID = selectedItemID
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(items) { item in
                    switch item {
                    case .playlist(let playlist):
                        PlaylistDetailView(playlist: playlist)
                            .containerRelativeFrame(.horizontal)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    default:
                        EmptyView()
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .contentMargins(20, for: .scrollContent)
        .listRowInsets(EdgeInsets())
        .scrollPosition(id: $selectedItemID)
        .ignoresSafeArea(edges: .bottom)
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { offset in
            print(offset)
        }
    }
}

//
//  HScrollMusicItemView.swift
//  Io
//
//  Created by Carson Gross on 3/31/24.
//

import SwiftUI
import MusicKit

struct HScrollMusicItemView: View {
    var items: MusicItemCollection<MusicPersonalRecommendation.Item>
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(items) { item in
                    NavigationLink(value: item) {
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
    }
}

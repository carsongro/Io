//
//  BrowseGridView.swift
//  Io
//
//  Created by Carson Gross on 4/2/24.
//

import SwiftUI

struct BrowseGridView: View {
    @Environment(BrowseModel.self) private var model
    
    var body: some View {
        List {
            ForEach(model.recommendations) { rec in
                let items = rec.browseItems()
                
                if !items.isEmpty {
                    Section {
                        Text(rec.title ?? "Recommended")
                            .font(.title2.bold())
                            .foregroundStyle(.primary)
                            .padding(.leading, 16)
                        
                        MusicItemCollectionMediumHScrollView(items: items) { item in
                            if rec.isMadeForYou() {
                                LargeMusicItemCell(artwork: item.artwork, title: item.title, subtitle: item.subtitle)
                            } else {
                                MediumMusicItemCell(artwork: item.artwork, title: item.title, subtitle: item.subtitle)
                            }
                        }
                    }
                }
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
            .listSectionSpacing(25)
        }
        .contentMargins(.bottom, 65, for: .scrollContent)
        .listStyle(.plain)
    }
}

#Preview {
    BrowseGridView()
        .environment(BrowseModel())
}

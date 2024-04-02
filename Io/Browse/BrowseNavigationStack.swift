//
//  BrowseNavigationStack.swift
//  Io
//
//  Created by Carson Gross on 3/31/24.
//

import SwiftUI
import MusicKit

struct BrowseNavigationStack: View {
    @State private var model = BrowseModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(model.recommendations) { rec in
                    let items = rec.items()
                    
                    if !items.isEmpty {
                        Section {
                            Text(rec.title ?? "Recommended")
                                .font(.title2.bold())
                                .foregroundStyle(.primary)
                                .padding(.leading, 16)
                            
                            MusicItemCollectionHScrollView(items: items)
                        }
                    }
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                .listSectionSpacing(25)
            }
            .contentMargins(.bottom, 65, for: .scrollContent)
            .listStyle(.plain)
            .navigationTitle("Browse")
        }
    }
}

#Preview {
    BrowseNavigationStack()
}

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
                //TODO: Add Secitions
                ForEach(model.sections) { section in
                    Section {
                        Text(section.title)
                            .font(.title2.bold())
                            .foregroundStyle(.primary)
                            .padding(.leading, 16)
                        
                        switch section {
                        case .items(let items):
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

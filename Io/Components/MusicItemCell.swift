//
//  MusicItemCell.swift
//  Io
//
//  Created by Carson Gross on 3/29/24.
//

import MusicKit
import SwiftUI

/// `MusicItemCell` is a view to use in a SwiftUI `List` to represent a `MusicItem`.
struct MusicItemCell: View {
    
    var artwork: Artwork?
    var title: String
    var subtitle: String?
    
    var body: some View {
        HStack {
            if let artwork {
                VStack {
                    Spacer()
                    ArtworkImage(artwork, width: 50)
                        .cornerRadius(6)
                    Spacer()
                }
            }
            
            VStack(alignment: .leading) {
                Text(title)
                    .lineLimit(1)
                    .foregroundColor(.primary)
                if let subtitle {
                    Text(subtitle)
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                        .padding(.top, -4.0)
                }
            }
            
            Spacer()
        }
    }
}


//
//  MediumMusicItemCell.swift
//  Io
//
//  Created by Carson Gross on 3/31/24.
//

import SwiftUI
import MusicKit

struct MediumMusicItemCell: View {
    var artwork: Artwork?
    var title: String
    var subtitle: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            if let artwork {
                ArtworkImage(artwork, width: 175, height: 175)
                    .overlay(ContainerRelativeShape().stroke(.ultraThinMaterial, lineWidth: 0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
            
            Text(title)
                .lineLimit(1)
            
            if let subtitle {
                Text(subtitle)
                    .lineLimit(1)
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
            }
        }
        .frame(width: 175)
    }
}

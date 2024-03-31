//
//  MediumMusicItemCell.swift
//  Io
//
//  Created by Carson Gross on 3/31/24.
//

import SwiftUI
import MusicKit

struct MediumMusicItemCell: View {
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    
    var artwork: Artwork?
    var title: String
    var subtitle: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            if let artwork {
                ArtworkImage(artwork, width: 185, height: 185)
                    .overlay(ContainerRelativeShape().stroke(.ultraThinMaterial, lineWidth: 0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .aspectRatio(contentMode: .fit)
                    .shadow(color: .black.opacity(0.175), radius: 8, y: 10)
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
        .frame(width: 185)
    }
}

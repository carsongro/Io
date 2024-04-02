//
//  LargeMusicItemCell.swift
//  Io
//
//  Created by Carson Gross on 4/2/24.
//

import SwiftUI
import MusicKit

struct LargeMusicItemCell: View {
    var artwork: Artwork?
    var title: String
    var subtitle: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .center, spacing: 0) {
                if let artwork {
                    ArtworkImage(artwork, width: 265, height: 265)
                        .aspectRatio(contentMode: .fit)
                        .overlay {
                            ContainerRelativeShape().stroke(.ultraThinMaterial, lineWidth: 0.5)
                        }
                }
                    
                
                if let artwork {
                    ArtworkImage(artwork, width: 265, height: 80)
                        .aspectRatio(contentMode: .fill)
                        .blur(radius: 20)
                        .clipped()
                        .overlay {
                            Rectangle()
                                .foregroundStyle(.thinMaterial)
                                .overlay {
                                    VStack {
                                        Text(title)
                                            .fontWeight(.semibold)
                                        
                                        if let subtitle {
                                            Text(subtitle)
                                        }
                                    }
                                    .font(.subheadline)
                                    .padding()
                                    .lineLimit(1)
                                }
                        }
                }
                    
            }
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .contentShape(Rectangle())
        .shadow(color: .black.opacity(0.075), radius: 5, y: 3)
    }
}

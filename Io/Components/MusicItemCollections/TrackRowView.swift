//
//  TrackRowView.swift
//  Io
//
//  Created by Carson Gross on 3/31/24.
//

import SwiftUI
import MusicKit

struct TrackRowView: View {
    var showArtwork: Bool
    let track: Track
    let idx: Int
    
    private var iconSize: CGFloat {
        showArtwork ? 48 : 30
    }
    
    var body: some View {
        HStack(alignment: .center) {
            if showArtwork, let artwork = track.artwork{
                ArtworkImage(artwork, width: iconSize, height: iconSize)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .aspectRatio(contentMode: .fit)
            } else {
                Rectangle()
                    .foregroundStyle(.clear)
                    .overlay {
                        Text(String(idx + 1))
                            .foregroundStyle(.secondary)
                    }
                    .frame(width: iconSize, height: iconSize)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .center) {
                    Text(track.title)
                        .lineLimit(1)
                        .padding(.vertical, showArtwork ? 0 : 8)
                    
                    if track.contentRating == .explicit {
                        RoundedRectangle(cornerRadius: 1.5, style: .continuous)
                            .foregroundStyle(.thinMaterial)
                            .overlay {
                                Text("E")
                                    .foregroundStyle(.secondary)
                                    .font(.caption2)
                                    .fontDesign(.rounded)
                                    .fontWeight(.semibold)
                            }
                            .frame(width: 12, height: 12)
                    }
                }
                
                if showArtwork {
                    Text(track.artistName)
                        .lineLimit(1)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
        }
        .contentShape(Rectangle())
    }
}

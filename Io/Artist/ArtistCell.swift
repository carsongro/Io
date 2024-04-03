//
//  ArtistCell.swift
//  Io
//
//  Created by Carson Gross on 4/3/24.
//

import SwiftUI
import MusicKit

struct ArtistCell: View {
    var artist: Artist
    var didSelect: () -> Void
    
    var body: some View {
        Button(action: didSelect) {
            HStack {
                if let artwork = artist.artwork {
                    VStack {
                        Spacer()
                        ArtworkImage(artwork, width: 56)
                            .clipShape(Circle())
                        Spacer()
                    }
                }
                
                VStack(alignment: .leading) {
                    Text(artist.name)
                    
                    Text("Artist")
                        .foregroundStyle(.secondary)
                }
            }
        }
        .buttonStyle(.plain)
    }
}


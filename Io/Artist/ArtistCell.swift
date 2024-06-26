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
    
    var body: some View {
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
            
            Spacer()
        }
        .contentShape(Rectangle())
    }
}


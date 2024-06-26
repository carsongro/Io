//
//  ArtistCellSmall.swift
//  Io
//
//  Created by Carson Gross on 4/3/24.
//

import SwiftUI
import MusicKit

struct ArtistCellSmall: View {
    let artist: Artist
    
    var body: some View {
        NavigationLink(value: artist) {
            VStack {
                if let artwork = artist.artwork {
                    VStack {
                        Spacer()
                        ArtworkImage(artwork, width: 100)
                            .clipShape(Circle())
                        Spacer()
                    }
                }
                
                Text(artist.name)
            }
        }
        .buttonStyle(.plain)
        .padding(.horizontal)
    }
}

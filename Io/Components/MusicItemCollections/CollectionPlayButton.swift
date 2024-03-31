//
//  CollectionPlayButton.swift
//  Io
//
//  Created by Carson Gross on 3/31/24.
//

import SwiftUI
import MusicKit

struct CollectionPlayButton: View {
    
    let playlist: Playlist?
    let album: Album?
    
    init(_ playlist: Playlist) {
        self.playlist = playlist
        self.album = nil
    }
    
    init(_ album: Album) {
        self.album = album
        self.playlist = nil
    }
    
    var body: some View {
        HStack {
            Button {
                // TODO: Play Music
                if let playlist {
                    
                } else if let album {
                    
                }
            } label: {
                HStack {
                    Image(systemName: "play.fill")
                    Text("Play")
                }
                .frame(maxWidth: 200)
            }
            .buttonStyle(.prominent)
        }
        .canOfferSubscription(disableContent: true)
    }
}

//
//  TrackListView.swift
//  Io
//
//  Created by Carson Gross on 3/31/24.
//

import SwiftUI
import MusicKit

struct TrackListView: View {
    var showArtwork: Bool
    let tracks: MusicItemCollection<Track>?
    
    var body: some View {
        if let tracks {
            ForEach(Array(zip(tracks.indices, tracks)), id: \.0) { idx, track in
                Button {
                    // TODO: Play Song
                } label: {
                    TrackRowView(showArtwork: showArtwork, track: track, idx: idx)
                }
                .buttonStyle(.plain)
                .listRowInsets(
                    EdgeInsets(
                        top: 6,
                        leading: 20,
                        bottom: 6,
                        trailing: 20
                    )
                )
                
                Divider()
            }
        }
    }
    
//    func hideArtwork(_ isHidden: Bool = false) -> TrackListView {
//        let listView = self
//        listView.showArtwork = !isHidden
//        return listView
//    }
}

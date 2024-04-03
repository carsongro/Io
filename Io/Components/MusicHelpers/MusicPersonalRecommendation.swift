//
//  MusicPersonalRecommendation.swift
//  Io
//
//  Created by Carson Gross on 4/3/24.
//

import Foundation
import MusicKit

extension MusicPersonalRecommendation {
    func browseItems() -> MusicItemCollection<MusicBrowseItem> {
        var items = MusicItemCollection<MusicBrowseItem>()
        
        // Filter out Stations
        items += MusicItemCollection<MusicBrowseItem>(self.items.compactMap {
            switch $0 {
            case .album(let album): MusicBrowseItem.album(album)
            case .playlist(let playlist): MusicBrowseItem.playlist(playlist)
            default: nil
            }
        })
        
        if items.isEmpty {
            items += MusicItemCollection<MusicBrowseItem>(playlists.compactMap {
                MusicBrowseItem.playlist($0)
            })
            
            items += MusicItemCollection<MusicBrowseItem>(albums.compactMap {
                MusicBrowseItem.album($0)
            })
        }
        
        return items
    }
    
    func isMadeForYou() -> Bool {
        title?.localizedCaseInsensitiveCompare("Made for You") == .orderedSame
    }
}

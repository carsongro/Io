//
//  MusicBrowseItem.swift
//  Io
//
//  Created by Carson Gross on 4/3/24.
//

import Foundation
import MusicKit

public enum MusicBrowseItem: MusicItem, Equatable, Hashable, Identifiable, Sendable, Decodable {
    /// An item that corresponds to an album.
    case album(Album)
    
    /// An item that corresponds to an artist.
    case artist(Artist)
    
    /// An item that corresponds to a curator.
    case curator(Curator)
    
    /// An item that corresponds to a music video.
    case musicVideo(MusicVideo)
    
    /// An item that corresponds to a playlist.
    case playlist(Playlist)
    
    /// An item that corresponds to a radio show.
    case radioShow(RadioShow)
    
    /// An item that corresponds to a record label.
    case recordLabel(RecordLabel)
    
    /// An item that corresponds to a song.
    case song(Song)
    
    /// An item that corresponds to a station.
    case station(Station)
    
    /// The unique identifier of this item.
    public var id: MusicItemID {
        switch self {
        case .album(let album):
            album.id
        case .artist(let artist):
            artist.id
        case .curator(let curator):
            curator.id
        case .musicVideo(let musicVideo):
            musicVideo.id
        case .playlist(let playlist):
            playlist.id
        case .radioShow(let radioShow):
            radioShow.id
        case .recordLabel(let recordLabel):
            recordLabel.id
        case .song(let song):
            song.id
        case .station(let station):
            station.id
        }
    }
    
    /// The artwork of this item.
    public var artwork: Artwork? {
        switch self {
        case .album(let album):
            album.artwork
        case .artist(let artist):
            artist.artwork
        case .curator(let curator):
            curator.artwork
        case .musicVideo(let musicVideo):
            musicVideo.artwork
        case .playlist(let playlist):
            playlist.artwork
        case .radioShow(let radioShow):
            radioShow.artwork
        case .recordLabel(let recordLabel):
            recordLabel.artwork
        case .song(let song):
            song.artwork
        case .station(let station):
            station.artwork
        }
    }
    
    /// The title of this item.
    public var title: String {
        switch self {
        case .album(let album):
            album.title
        case .artist(let artist):
            artist.name
        case .curator(let curator):
            curator.name
        case .musicVideo(let musicVideo):
            musicVideo.title
        case .playlist(let playlist):
            playlist.name
        case .radioShow(let radioShow):
            radioShow.name
        case .recordLabel(let recordLabel):
            recordLabel.name
        case .song(let song):
            song.title
        case .station(let station):
            station.name
        }
    }
    
    /// The subtitle of this item.
    public var subtitle: String? {
        switch self {
        case .album(let album):
            album.artistName
        case .artist:
            nil
        case .curator:
            nil
        case .musicVideo:
            nil
        case .playlist(let playlist):
            playlist.description
        case .radioShow:
            nil
        case .recordLabel:
            nil
        case .song(let song):
            song.artistName
        case .station(let station):
            station.description
        }
    }
}

extension MusicBrowseItem: FilterableMusicItem {
    public typealias FilterType = TopResultFilter
}

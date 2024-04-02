//
//  Extensions.swift
//  Io
//
//  Created by Carson Gross on 3/31/24.
//

import SwiftUI
import MusicKit

struct PrefersTabNavigationEnvironmentKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

extension EnvironmentValues {
    var prefersTabNavigation: Bool {
        get { self[PrefersTabNavigationEnvironmentKey.self] }
        set { self[PrefersTabNavigationEnvironmentKey.self] = newValue }
    }
}

#if os(iOS)
extension PrefersTabNavigationEnvironmentKey: UITraitBridgedEnvironmentKey {
    static func read(from traitCollection: UITraitCollection) -> Bool {
        return traitCollection.userInterfaceIdiom == .phone || traitCollection.userInterfaceIdiom == .tv
    }
    
    static func write(to mutableTraits: inout UIMutableTraits, value: Bool) {
        // Do not write.
    }
}
#endif

struct NavigationDestinations: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: Playlist.self, destination: PlaylistDetailView.init)
            .navigationDestination(for: MusicPersonalRecommendation.Item.self) { item in
                switch item {
                case .playlist(let playlist):
                    PlaylistDetailView(playlist: playlist)
                default:
                    EmptyView()
                }
            }
    }
}

extension View {
    func musicNavigationDestinations() -> some View {
        self
            .modifier(NavigationDestinations())
    }
    
    func notvisionOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if !os(visionOS)
        return modifier(self)
        #else
        return self
        #endif
    }
    
    func gradientBackground() -> some View {
        var gradient: some View {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: (130.0 / 255.0), green: (109.0 / 255.0), blue: (204.0 / 255.0)),
                    Color(red: (130.0 / 255.0), green: (130.0 / 255.0), blue: (211.0 / 255.0)),
                    Color(red: (131.0 / 255.0), green: (160.0 / 255.0), blue: (218.0 / 255.0))
                ]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .flipsForRightToLeftLayoutDirection(false)
            .ignoresSafeArea()
        }
        
        return self.background(gradient)
    }
}

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}

extension MusicPersonalRecommendation {
    func items() -> MusicItemCollection<MusicPersonalRecommendation.Item> {
        var items = MusicItemCollection<MusicPersonalRecommendation.Item>()
        
        // Filter out Stations
        items += MusicItemCollection<MusicPersonalRecommendation.Item>(self.items.compactMap {
            switch $0 {
            case .album: $0
            case .playlist: $0
            default: nil
            }
        })
        
        if items.isEmpty {
            items += MusicItemCollection<MusicPersonalRecommendation.Item>(playlists.compactMap {
                MusicPersonalRecommendation.Item.playlist($0)
            })
            
            items += MusicItemCollection<MusicPersonalRecommendation.Item>(albums.compactMap {
                MusicPersonalRecommendation.Item.album($0)
            })
        }
        
        return items
    }
    
    func isMadeForYou() -> Bool {
        title?.localizedCaseInsensitiveCompare("Made for You") == .orderedSame
    }
}

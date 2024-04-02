//
//  MusicItemCollectionDetailModifier.swift
//  Io
//
//  Created by Carson Gross on 3/31/24.
//

import SwiftUI
import MusicKit

struct MusicItemWith<Item: MusicItem>: ViewModifier where Item : MusicPropertyContainer, Item : Decodable {
    let item: Item
    let properties: [PartialMusicAsyncProperty<Item>]
    let didFetch: (Item) -> Void
    
    init(
        _ properties: [PartialMusicAsyncProperty<Item>],
        from item: Item,
        didFetch: @escaping @Sendable (Item) -> Void
    ) {
        self.properties = properties
        self.item = item
        self.didFetch = didFetch
    }
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                Task {
                    await getDetailedItem()
                }
            }
    }
    
    private func getDetailedItem() async {
        do {
            let detailedItem = try await item.with(properties)
            didFetch(detailedItem)
        } catch {
            print("❌ Error fetching detailed MusicItem: \(error.localizedDescription)")
        }
    }
}

extension View {
    func musicItemWith<Item: MusicItem>(
        _ properties: PartialMusicAsyncProperty<Item>...,
        from item: Item,
        didFetch: @escaping @Sendable (Item) -> Void
    ) -> some View where Item : MusicPropertyContainer, Item : Decodable {
        modifier(MusicItemWith(properties, from: item, didFetch: didFetch))
    }
}

//
//  MusicItemCollectionDetailModifier.swift
//  Io
//
//  Created by Carson Gross on 3/31/24.
//

import SwiftUI
import MusicKit

public struct MusicItemWith<Item: MusicItem>: ViewModifier where Item : MusicPropertyContainer, Item : Decodable {
    private let item: Item
    private let properties: [PartialMusicAsyncProperty<Item>]
    private let didFetch: (Item) -> Void
    
    init(
        _ properties: [PartialMusicAsyncProperty<Item>],
        from item: Item,
        didFetch: @escaping @Sendable (Item) -> Void
    ) {
        self.properties = properties
        self.item = item
        self.didFetch = didFetch
    }
    
    public func body(content: Content) -> some View {
        ThrowingView {
            content
        } label: {
            Text("Error")
        } description: {
            Text("There was an error loading data.")
        } operation: {
            try await getDetailedItem()
        }

    }
    
    private func getDetailedItem() async throws {
        let detailedItem = try await item.with(properties)
        didFetch(detailedItem)
    }
}

extension View {
    public func musicItemWith<Item: MusicItem>(
        _ properties: PartialMusicAsyncProperty<Item>...,
        from item: Item,
        didFetch: @escaping @Sendable (Item) -> Void
    ) -> some View where Item : MusicPropertyContainer, Item : Decodable {
        modifier(MusicItemWith(properties, from: item, didFetch: didFetch))
    }
}

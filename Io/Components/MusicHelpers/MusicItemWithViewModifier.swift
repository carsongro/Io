//
//  MusicItemWithViewModifier.swift
//  Io
//
//  Created by Carson Gross on 3/31/24.
//

import SwiftUI
import MusicKit

public struct MusicItemWithViewModifier<Item: MusicItem>: ViewModifier where Item : MusicPropertyContainer, Item : Decodable {
    private let item: Item
    private let properties: [PartialMusicAsyncProperty<Item>]
    @Binding private var detailedItem: Item?
    
    init(
        _ properties: [PartialMusicAsyncProperty<Item>],
        from item: Item,
        detailedItem: Binding<Optional<Item>>
    ) {
        self.properties = properties
        self.item = item
        _detailedItem = detailedItem
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
        detailedItem = try await item.with(properties)
    }
}

extension View {
    public func musicItemWith<Item: MusicItem>(
        _ properties: PartialMusicAsyncProperty<Item>...,
        from item: Item,
        detailedItem: Binding<Optional<Item>>
    ) -> some View where Item : MusicPropertyContainer, Item : Decodable {
        modifier(MusicItemWithViewModifier(properties, from: item, detailedItem: detailedItem))
    }
}

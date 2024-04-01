//
//  SubscriptionOfferableView.swift
//  Io
//
//  Created by Carson Gross on 3/29/24.
//

import SwiftUI
import MusicKit

public struct SubscriptionOfferableView<Content: View>: View {
    private let itemID: MusicItemID?
    private let messageIdentifier: MusicSubscriptionOffer.MessageIdentifier
    private let content: Content
    
    @State private var musicSubscription: MusicSubscription?
    @State private var isShowingSubscriptionOffer = false
    @State private var subscriptionOfferOptions: MusicSubscriptionOffer.Options = .default
    
    private var disabled = false
    
    init(
        itemID: MusicItemID? = nil,
        messageIdentifier: MusicSubscriptionOffer.MessageIdentifier = .join,
        @ViewBuilder content: () -> Content
    ) {
        self.itemID = itemID
        self.messageIdentifier = messageIdentifier
        self.content = content()
    }
    
    private var shouldOfferSubscription: Bool {
        let canBecomeSubscriber = musicSubscription?.canBecomeSubscriber ?? false
        return canBecomeSubscriber
    }
    
    public var body: some View {
        Group {
            if shouldOfferSubscription {
                content
                    .disabled(disabled)
                    .onTapGesture(perform: handleSubscriptionOfferSelected)
            } else {
                content
            }
        }
        .task {
            for await subscription in MusicSubscription.subscriptionUpdates {
                musicSubscription = subscription
            }
        }
        .musicSubscriptionOffer(isPresented: $isShowingSubscriptionOffer, options: subscriptionOfferOptions)
    }
    
    /// Computes the presentation state for a subscription offer.
    private func handleSubscriptionOfferSelected() {
        subscriptionOfferOptions.messageIdentifier = messageIdentifier
        subscriptionOfferOptions.itemID = itemID
        isShowingSubscriptionOffer = true
    }
    
    /// Can disable the underlying content if a subsription should be offered.
    /// - Parameter disabled: A boolean indicating whether the underlying content is disabled or not.
    /// - Returns: `SubscriptionOfferableView`
    public func contentDisabled(_ disabled: Bool = true) -> SubscriptionOfferableView {
        var view = self
        view.disabled = disabled
        return view
    }
}

public struct SubscriptionOfferableModifier: ViewModifier {
    let itemID: MusicItemID?
    let messageIdentifier: MusicSubscriptionOffer.MessageIdentifier
    let disableContent: Bool
    
    public func body(content: Content) -> some View {
        SubscriptionOfferableView(itemID: itemID, messageIdentifier: messageIdentifier) {
            content
        }
        .contentDisabled(disableContent)
    }
}

extension View {
    func canOfferSubscription(
        for itemID: MusicItemID? = nil,
        messageIdentifier: MusicSubscriptionOffer.MessageIdentifier = .join,
        disableContent: Bool = false
    ) -> some View {
        modifier(SubscriptionOfferableModifier(itemID: itemID, messageIdentifier: messageIdentifier, disableContent: disableContent))
    }
}

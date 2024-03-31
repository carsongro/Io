//
//  CollectionHeader.swift
//  Io
//
//  Created by Carson Gross on 3/29/24.
//

import SwiftUI
import MusicKit

struct CollectionHeader: View {
    var artwork: Artwork?
    var title: String
    var ownerName: String?
    var description: String?
    var itemCount: Int?
    
    var body: some View {
        VStack {
            HStack {
                if let artwork {
                    ArtworkImage(artwork, width: 320)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                VStack {
                    Text(title)
                        .font(.largeTitle.bold())
                    
                    if let description {
                        Text(description)
                            .foregroundStyle(.secondary)
                            .font(.caption)
                    }
                    
                    Text(collectionDetails)
                }
            }
        }
    }
    
    var collectionDetails: String {
        let ownerNameText = if let ownerName { ownerName } else { "" }
        let itemCountText = if let itemCount { "\(String(itemCount)) songs" } else { "" }
        let dividerDot = ownerNameText.isEmpty && itemCountText.isEmpty ? "" : "\u{2022}"
        return ownerNameText + dividerDot + itemCountText
    }
}

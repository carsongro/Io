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
    
    private var collectionDetails: String {
        let ownerNameText = if let ownerName { ownerName } else { "" }
        let itemCountText = if let itemCount { "\(String(itemCount)) songs" } else { "" }
        let dividerDot = ownerNameText.isEmpty && itemCountText.isEmpty ? "" : "\u{2022}"
        return ownerNameText + dividerDot + itemCountText
    }
    
    var body: some View {
        VStack(spacing: 10) {
            if let artwork {
                ArtworkImage(artwork, width: 320, height: 320)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
            
            if let ownerName {
                Text(ownerName)
            }
        }
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
    }
}

//
//  ScrollOffsetPreferenceKey.swift
//  Io
//
//  Created by Carson Gross on 3/31/24.
//

import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue = CGFloat.zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

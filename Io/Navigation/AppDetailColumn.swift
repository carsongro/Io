//
//  AppDetailColumn.swift
//  Io
//
//  Created by Carson Gross on 3/29/24.
//

import SwiftUI

struct AppDetailColumn: View {
    var screen: AppScreen?
    
    var body: some View {
        if let screen {
            screen.destination
        } else {
            ContentUnavailableView("Browse Music", systemImage: "music.note", description: Text("Pick items to browse from the list"))
        }
    }
}

#Preview {
    AppDetailColumn()
}

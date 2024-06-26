//
//  WelcomeBackgroundView.swift
//  Io
//
//  Created by Carson Gross on 4/1/24.
//

import SwiftUI

struct WelcomeBackgroundView: View {
    let upperLimit = 21.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @State private var currentSeconds = 0.0
    
    var body: some View {
        Group {
            if 0..<3.4 ~= currentSeconds {
                RollinRainbowView()
            } else if 3.4..<9.0 ~= currentSeconds {
                RedactedGrid()
            } else if 9.0..<12.4 ~= currentSeconds {
                DancingDotsView()
            } else if 12.4..<15 ~= currentSeconds {
                RainbowGridView()
            } else if 15..<17 ~= currentSeconds {
                GlitchedTextEffect(timer: timer)
                    .foregroundStyle(.white)
            } else if 17...upperLimit ~= currentSeconds {
                EruptEffect()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onReceive(timer) { _ in
            currentSeconds = rounded(currentSeconds) >= upperLimit ? 0 : currentSeconds + 0.1
        }
    }
    
    private func rounded(_ n: Double) -> Double { round(n * 10) / 10.0 }
}

#Preview {
    WelcomeBackgroundView()
}

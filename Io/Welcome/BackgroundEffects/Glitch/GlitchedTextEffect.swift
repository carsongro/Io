//
//  GlitchedTextEffect.swift
//  Io
//
//  Created by Carson Gross on 4/1/24.
//

import SwiftUI
import Combine

struct GlitchedTextEffect: View {
    @State private var showGlitched: Bool
    @State private var currentSeconds = 0.0
    
    let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    let hapticsEnabled: Bool
    let upperLimit: Double
    let stages: [Double: Double?]
    let isGlitched: ((Bool) -> Void)?
    
    /// Initializer for `GlitchedText`
    /// - Parameters:
    ///   - text: A `String` that will be displayed. Defaults to "Impossible"
    ///   - upperLimit: A `Double` that determines when the glitch animation resets. Defaults to 2.0.
    ///   - stages: A dictionary where key is the timestamp and the value is the duration of the haptics starting at the timestamp.
    ///   Keys must be multiples of 0.1. Nil means no haptics will occur.
    ///   - hapticsEnabled: A `Bool` indicating whether or not haptics will be played when glitching. Defaults to true
    ///   - isGlitched: A closure that is called when the state changes between showing glitched or not.
    init(
        timer: Publishers.Autoconnect<Timer.TimerPublisher> = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect(),
        hapticsEnabled: Bool = true,
        upperLimit: Double = 2.0,
        stages: [Double: Double?] = [
            0.0: nil,
            0.2: 0.6,
            0.8: nil,
            1.8: 0.2
        ],
        isGlitched: ((Bool) -> Void)? = nil
    ) {
        self.timer = timer
        self.hapticsEnabled = hapticsEnabled
        self.upperLimit = upperLimit
        self.stages = stages
        _showGlitched = State(initialValue: stages[0.0, default: nil] != nil)
        self.isGlitched = isGlitched
    }
    
    var body: some View {
        GlitchedText(showGlitched: showGlitched)
            .onAppear(perform: CoreHapticsManager.shared.startEngine)
            .onReceive(timer) { _ in
                currentSeconds = rounded(currentSeconds) == upperLimit ? 0 : currentSeconds + 0.1
                
                for (timestamp, duration) in stages {
                    if rounded(currentSeconds) == timestamp {
                        if let duration {
                            showGlitched = true
                            if hapticsEnabled {
                                CoreHapticsManager.shared.glitchHaptic(duration: duration)
                            }
                        } else {
                            showGlitched = false
                        }
                    }
                }
            }
            .onChange(of: showGlitched) { isGlitched?($1) }
    }
    
    private func rounded(_ n: Double) -> Double { round(n * 10) / 10.0 }
}

#Preview {
    GlitchedTextEffect()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .foregroundStyle(.white)
}

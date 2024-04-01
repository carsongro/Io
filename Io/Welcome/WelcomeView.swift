//
//  WelcomeView.swift
//  Io
//
//  Created by Carson Gross on 3/31/24.
//

import MusicKit
import SwiftUI

struct WelcomeView: View {
    @Environment(\.openURL) private var openURL
    
    @Binding var musicAuthorizationStatus: MusicAuthorization.Status
    
    var body: some View {
        VStack {
            Text("Io")
                .font(.largeTitle.weight(.semibold))
                .shadow(radius: 2)
                .padding(.bottom, 1)
            explanatoryText
                .font(.title3.weight(.medium))
                .multilineTextAlignment(.center)
                .shadow(radius: 1)
                .padding([.leading, .trailing], 32)
                .padding(.bottom, 16)
            if let secondaryExplanatoryText {
                secondaryExplanatoryText
                    .font(.title3.weight(.medium))
                    .multilineTextAlignment(.center)
                    .shadow(radius: 1)
                    .padding([.leading, .trailing], 32)
                    .padding(.bottom, 16)
            }
            
            if musicAuthorizationStatus == .notDetermined || musicAuthorizationStatus == .denied {
                Button(buttonText, action: handleButtonPressed)
                    .buttonStyle(.prominent)
                    .buttonBorderShape(.capsule)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .gradientBackground()
    }
    
    private var explanatoryText: Text {
        let explanatoryText: Text
        switch musicAuthorizationStatus {
        case .restricted:
            explanatoryText = Text("Io cannot be used on this iPhone because usage of ")
            + Text(Image(systemName: "applelogo")) + Text(" Music is restricted.")
        default:
            explanatoryText = Text("Io uses ")
            + Text(Image(systemName: "applelogo")) + Text(" Music\nto help you rediscover your music.")
        }
        return explanatoryText
    }
    
    private var secondaryExplanatoryText: Text? {
        var secondaryExplanatoryText: Text?
        switch musicAuthorizationStatus {
        case .denied:
            secondaryExplanatoryText = Text("Please grant Io access to ")
            + Text(Image(systemName: "applelogo")) + Text(" Music in Settings.")
        default:
            break
        }
        return secondaryExplanatoryText
    }
    
    private var buttonText: String {
        let buttonText = switch musicAuthorizationStatus {
        case .notDetermined:
            "Continue"
        case .denied:
            "Open Settings"
        default:
            fatalError("No button should be displayed for current authorization status: \(musicAuthorizationStatus).")
        }
        return buttonText
    }
    
    private func handleButtonPressed() {
        switch musicAuthorizationStatus {
        case .notDetermined:
            Task {
                let musicAuthorizationStatus = await MusicAuthorization.request()
                await update(with: musicAuthorizationStatus)
            }
        case .denied:
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                openURL(settingsURL)
            }
        default:
            fatalError("No button should be displayed for current authorization status: \(musicAuthorizationStatus).")
        }
    }
    
    @MainActor
    private func update(with musicAuthorizationStatus: MusicAuthorization.Status) {
        withAnimation {
            self.musicAuthorizationStatus = musicAuthorizationStatus
        }
    }
}

#Preview {
    WelcomeView(musicAuthorizationStatus: .constant(.notDetermined))
}



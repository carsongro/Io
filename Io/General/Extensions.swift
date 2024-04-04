//
//  Extensions.swift
//  Io
//
//  Created by Carson Gross on 3/31/24.
//

import SwiftUI
import MusicKit

struct PrefersTabNavigationEnvironmentKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

extension EnvironmentValues {
    var prefersTabNavigation: Bool {
        get { self[PrefersTabNavigationEnvironmentKey.self] }
        set { self[PrefersTabNavigationEnvironmentKey.self] = newValue }
    }
}

#if os(iOS)
extension PrefersTabNavigationEnvironmentKey: UITraitBridgedEnvironmentKey {
    static func read(from traitCollection: UITraitCollection) -> Bool {
        return traitCollection.userInterfaceIdiom == .phone || traitCollection.userInterfaceIdiom == .tv
    }
    
    static func write(to mutableTraits: inout UIMutableTraits, value: Bool) {
        // Do not write.
    }
}
#endif

extension View {
    func notvisionOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if !os(visionOS)
        return modifier(self)
        #else
        return self
        #endif
    }
    
    func gradientBackground() -> some View {
        var gradient: some View {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: (130.0 / 255.0), green: (109.0 / 255.0), blue: (204.0 / 255.0)),
                    Color(red: (130.0 / 255.0), green: (130.0 / 255.0), blue: (211.0 / 255.0)),
                    Color(red: (131.0 / 255.0), green: (160.0 / 255.0), blue: (218.0 / 255.0))
                ]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .flipsForRightToLeftLayoutDirection(false)
            .ignoresSafeArea()
        }
        
        return self.background(gradient)
    }
}

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}

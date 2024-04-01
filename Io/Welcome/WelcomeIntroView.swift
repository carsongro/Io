//
//  WelcomeIntroView.swift
//  Io
//
//  Created by Carson Gross on 4/1/24.
//

import SwiftUI

enum StepType {
    case intro, auth
}

struct WelcomeStep: Identifiable {
    var id: Int
    var name: String
    var type: StepType
    
    static var all: [WelcomeStep] {
        [
            .init(id: 1, name: "", type: .intro),
            .init(id: 2, name: "Auth", type: .auth)
        ]
    }
    
    static func name(_ id: Int) -> String {
        WelcomeStep.all.first { $0.id == id }?.name ?? ""
    }
}

struct WelcomeIntroView: View {
    @Environment(Navigator.self) private var navigator
    
    @State private var welcomePosition: Int? = WelcomeStep.all.first?.id
    @State private var playingVideo = true
    
    var body: some View {
        @Bindable var navigator = navigator
        
        ScrollView {
            LazyVStack {
                ForEach(WelcomeStep.all) { step in
                    Group {
                        switch step.type {
                        case .intro: 
                            arrowUpView
                        case .auth: 
                            WelcomeView(musicAuthorizationStatus: $navigator.musicAuthorizationStatus)
                                .containerRelativeFrame(.vertical)
                        }
                    }
                    .foregroundStyle(.white)
                    .scrollTransition { content, phase in
                        content
                            .opacity(phase.isIdentity ? 1 : 0.2)
                            .scaleEffect(phase.isIdentity ? 1 : 0.9)
                            .blur(radius: phase.isIdentity ? 0 : 8)
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: $welcomePosition)
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.paging)
        .background {
            if playingVideo{
                WelcomeBackgroundView()
            } else {
                Color.clear
                    .gradientBackground()
            }
        }
        .ignoresSafeArea()
        .onChange(of: welcomePosition) {
            withAnimation(.bouncy) {
                playingVideo = welcomePosition == 1
            }
        }
        .onAppear(perform: CoreHapticsManager.shared.prepareHaptics)
    }
    
    private var arrowUpView: some View {
        VStack {
            Spacer()
            
            Button {
                withAnimation {
                    if let welcomePosition {
                        self.welcomePosition = welcomePosition + 1
                    }
                }
            } label: {
                Image(systemName: "arrow.up")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22)
                    .foregroundStyle(.white)
                    .opacity(0.6)
                    .padding(12)
                    .background(.ultraThinMaterial, in: Circle())
                    .padding(20)
            }
        }
        .safeAreaPadding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
        .containerRelativeFrame(.vertical)
    }
}

#Preview {
    WelcomeIntroView()
        .environment(Navigator.shared)
}

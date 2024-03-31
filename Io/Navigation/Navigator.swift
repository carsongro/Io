//
//  Navigator.swift
//  Io
//
//  Created by Carson Gross on 3/29/24.
//

import Foundation
import MusicKit

@Observable
final class Navigator {
    static let shared = Navigator()
    
    private init() {
        let authorizationStatus = MusicAuthorization.currentStatus
        musicAuthorizationStatus = authorizationStatus
        isWelcomeViewPresented = (authorizationStatus != .authorized)
    }
    
    //MARK: - MusicKit Authorization
    
    var musicAuthorizationStatus: MusicAuthorization.Status {
        didSet {
            isWelcomeViewPresented = (musicAuthorizationStatus != .authorized)
        }
    }
    
    var isWelcomeViewPresented: Bool
    
    //MARK: - Navigation
    
    var selectedScreen: AppScreen? = .home
}

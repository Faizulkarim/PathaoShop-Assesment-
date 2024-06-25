//
//  AnalyticsManager.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 23/7/23.
//

import Foundation

/// Analytics manager protocol.
public protocol AnalyticsManager {
    
    /// Starts the analytics manager.
    func start()
    
    /// Tracks viewing of the provided screen.
    ///
    /// - Parameter screen: Screen.
    func track(screenView screen: AnalyticsScreen)
    
}

/// DefaultAnalyticsManager.
struct DefaultAnalyticsManager: AnalyticsManager {
    func start() {
        
    }
    
    func track(screenView screen: AnalyticsScreen) {
        
    }
}

//
//  UtilityFactory.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 23/7/23.
//


import Foundation
protocol UtilityFactory {
    func launchSequencer() -> LaunchSequencer
    func analyticsManager() -> AnalyticsManager
    func apiManager() -> OTAPIManager
    func theme() -> Theme
}

//
//  BuilderFactory.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 23/7/23.
//


import Foundation

protocol BuilderFactory {
    func splashBuilder() -> SplashBuildable
    func homeBuilder() -> HomeViewBuildable
    func categoryItembuilder() -> CategoryItemBuildable
    func storeBuilder() -> StoreBuildable
    
    
}

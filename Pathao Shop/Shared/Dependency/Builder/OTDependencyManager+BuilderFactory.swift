//
//  OTDependencyManager+BuilderFactory.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 23/7/23.
//


import Foundation

extension OTDependencyManager {
    func splashBuilder() -> SplashBuildable {
        return SplashBuilder(dependencyManager: OTDependencyManager.defaultValue)
    }

    func homeBuilder() -> HomeViewBuildable {
        return HomeViewBuilder(dependencyManager: OTDependencyManager.defaultValue)
    }
  
    func categoryItembuilder() -> CategoryItemBuildable {
        return CategoryItemBuilder(dependencyManager: OTDependencyManager.defaultValue)
    }
    func storeBuilder() -> StoreBuildable {
        return StoreBuilder(dependencyManager: OTDependencyManager.defaultValue)
    }
    
    
}

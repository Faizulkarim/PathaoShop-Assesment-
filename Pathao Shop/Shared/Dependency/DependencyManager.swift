//
//  DependencyManager.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 23/7/23.
//


import Foundation
import UIKit

protocol DependencyManager: BuilderFactory, UtilityFactory {
    
    ///  Configured dependency manager for usage.
    /// - warning: Should be called before attempting to start or access dependencies.
    ///
    /// - Parameters:
    ///   - rootWindow: Root window of application.
    func configure(rootWindow: UIWindow?)
    

    
}

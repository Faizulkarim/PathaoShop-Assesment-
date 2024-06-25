//
//  SplashBuildable.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 23/7/23.
//

import Foundation
import UIKit

/// Splash builder protocol.
protocol SplashBuildable {

    /// Builds the Splash view.
    ///
    /// - Returns: Splash details view.
    func build() -> UIViewController

}

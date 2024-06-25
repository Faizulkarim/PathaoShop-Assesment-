//
//  HomeViewBuildable.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 23/7/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

/// HomeView builder protocol.
protocol HomeViewBuildable {

    /// Builds the HomeView view.
    ///
    /// - Returns: HomeView details view.
    func build() -> UIViewController

}

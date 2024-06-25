//
//  CategoryItemBuildable.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 28/7/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

/// CategoryItem builder protocol.
protocol CategoryItemBuildable {

    /// Builds the CategoryItem view.
    ///
    /// - Returns: CategoryItem details view.
    func build() -> UIViewController

}

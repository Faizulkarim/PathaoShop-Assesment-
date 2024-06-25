//
//  CategoryItemDisplayModelBuilder.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 28/7/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Foundation
import Combine

// MARK: CategoryItemDisplayModelBuilder
struct CategoryItemDisplayModelBuilder {
    
    /// Transform the response model to display model
    ///
    /// - Parameters:
    ///   - model: Codable model.
    static func viewModel<T>(from model: T) -> CategoryItemDisplayModel {
        return CategoryItemDisplayModel()
    }
}

//
//  StoreBuildable.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 28/7/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

/// Store builder protocol.
protocol StoreBuildable {

    /// Builds the Store view.
    ///
    /// - Returns: Store details view.
    func build() -> UIViewController

}

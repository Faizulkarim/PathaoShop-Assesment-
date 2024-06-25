//
//  CategoryItemViewModelType.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 28/7/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Combine

// MARK: CategoryItemViewModelInput
struct CategoryItemViewModelInput {
    let viewDidLoad: AnyPublisher<Void, Never>
}

// MARK: ViewModelOutput
struct CategoryItemViewModelOutput {
    let viewState: AnyPublisher<CategoryItemViewState, Never>
}

// MARK: ViewState
enum CategoryItemViewState {
    case viewDidLoad
    case loading(shouldShow: Bool)
}

// MARK: CategoryItemViewModelType
protocol CategoryItemViewModelType {
    /// Passing input publishers to get output publishers for sink i.e to observe
    func transform(input: CategoryItemViewModelInput) -> CategoryItemViewModelOutput
}

//
//  StoreViewModelType.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 28/7/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Combine

// MARK: StoreViewModelInput
struct StoreViewModelInput {
    let viewDidLoad: AnyPublisher<Void, Never>
}

// MARK: ViewModelOutput
struct StoreViewModelOutput {
    let viewState: AnyPublisher<StoreViewState, Never>
}

// MARK: ViewState
enum StoreViewState {
    case viewDidLoad
    case loading(shouldShow: Bool)
}

// MARK: StoreViewModelType
protocol StoreViewModelType {
    /// Passing input publishers to get output publishers for sink i.e to observe
    func transform(input: StoreViewModelInput) -> StoreViewModelOutput
}

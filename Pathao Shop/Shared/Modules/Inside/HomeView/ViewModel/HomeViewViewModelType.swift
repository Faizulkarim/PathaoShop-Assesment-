//
//  HomeViewViewModelType.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 23/7/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Combine

// MARK: HomeViewViewModelInput
struct HomeViewViewModelInput {
    let viewDidLoad: AnyPublisher<Void, Never>
    let shopApiSubject : AnyPublisher<Parameters, Never>
}

// MARK: ViewModelOutput
struct HomeViewViewModelOutput {
    let viewState: AnyPublisher<HomeViewViewState, Never>
}

// MARK: ViewState
enum HomeViewViewState {
    case viewDidLoad
    case loading(shouldShow: Bool)
    case apiFailure(customError: OTError)
    case apiSuccess(response: [ShopResponseModel]?)
}

// MARK: HomeViewViewModelType
protocol HomeViewViewModelType {
    /// Passing input publishers to get output publishers for sink i.e to observe
    func transform(input: HomeViewViewModelInput) -> HomeViewViewModelOutput
}

//
//  StoreViewModel.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 28/7/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import Combine

// MARK: StoreViewModel
final class StoreViewModel {
    
    // MARK: Private variables
    private var disposeBag: DisposeBag = DisposeBag()
    private let apiManager: OTAPIManager
    private var displayModel: StoreDisplayModel = StoreDisplayModel()

    // MARK: Init Functions

    /// Initializes the model
    ///
    /// - Parameters:
    ///   - apiManager: APIManager manager.
    init(apiManager: OTAPIManager) {
        self.apiManager = apiManager
    }

    private func viewModels<T>(from models: [T]) -> [StoreDisplayModel] {
        return models.map { StoreDisplayModelBuilder.viewModel(from: $0)}
    }
    
}

// MARK: StoreViewModelType

/// Get StoreViewModelType protocol methods
extension StoreViewModel: StoreViewModelType {

    /// Passing input publishers to get output publishers for sink i.e to observe
    func transform(input: StoreViewModelInput) -> StoreViewModelOutput {
        /// Clear all observer
        disposeBag.cancel()

        // Observe viewDidload event and perform action
        let viewDidLoadPublisher = input.viewDidLoad
            .map({ input -> StoreViewState in
                return .viewDidLoad
                })
            .eraseToAnyPublisher()

        // If there any service call during view load so call it and
        // return success with response model or just return empty
        // response with success call as below
        return StoreViewModelOutput.init(viewState: viewDidLoadPublisher)
    }

}

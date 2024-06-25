//
//  HomeViewViewModel.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 23/7/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import Combine

// MARK: HomeViewViewModel
final class HomeViewViewModel {
    
    // MARK: Private variables
    private var disposeBag: DisposeBag = DisposeBag()
    private let apiManager: OTAPIManager
    private var displayModel: HomeViewDisplayModel = HomeViewDisplayModel()

    // MARK: Init Functions

    /// Initializes the model
    ///
    /// - Parameters:
    ///   - apiManager: APIManager manager.
    init(apiManager: OTAPIManager) {
        self.apiManager = apiManager
    }

    private func viewModels<T>(from models: [T]) -> [HomeViewDisplayModel] {
        return models.map { HomeViewDisplayModelBuilder.viewModel(from: $0)}
    }
    
}

// MARK: HomeViewViewModelType

/// Get HomeViewViewModelType protocol methods
extension HomeViewViewModel: HomeViewViewModelType {

    /// Passing input publishers to get output publishers for sink i.e to observe
    func transform(input: HomeViewViewModelInput) -> HomeViewViewModelOutput {
        /// Clear all observer
        disposeBag.cancel()

        // Observe viewDidload event and perform action
        let viewDidLoadPublisher = input.viewDidLoad
            .map({ input -> HomeViewViewState in
                return .viewDidLoad
                })
            .eraseToAnyPublisher()
        
        
        
        let shopApiPublisher : PassthroughSubject<HomeViewViewState, Never> = .init()
        input.shopApiSubject.flatMap { requestModel -> AnyPublisher<Result<[ShopResponseModel]?, OTError>, Never> in
            shopApiPublisher.send(.loading(shouldShow: true))
            return self.apiManager.getShop(requestModel)
        }.sink { result in
            DispatchQueue.main.async {
                shopApiPublisher.send(.loading(shouldShow: false))
                switch result {
                case .success(let response):
                    shopApiPublisher.send(.apiSuccess(response: response))
                case .failure(let error):
                    shopApiPublisher.send(.apiFailure(customError: error))
                }
            }
        }.store(in: disposeBag)


        let viewDidLoadAndLoadDataPublisher = Publishers.MergeMany(viewDidLoadPublisher,shopApiPublisher.eraseToAnyPublisher()).eraseToAnyPublisher()

        // If there any service call during view load so call it and
        // return success with response model or just return empty
        // response with success call as below
        return HomeViewViewModelOutput.init(viewState: viewDidLoadAndLoadDataPublisher)
    }

}

//
//  HomeViewRouter.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 23/7/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
import Foundation
import UIKit

/// HomeViewRouter list router. Responsible for navigating from the view.
final class HomeViewRouter {
    /// The navigation controller to use for navigation.
    weak var navigationController: UINavigationController?
    
    /// View controller used to present other views.
    weak var viewController: UIViewController?
    private let dependencyManager: DependencyManager
    
    /// Initializes the view router.
    ///
    /// - Parameter dependencyManager: The app dependency manager.
    init(dependencyManager: DependencyManager) {
        self.dependencyManager = dependencyManager
    }
    
    // MARK: - Instance functions
    
    /*
     /// Example method to implement for route.
     ///
     func routeToView() {}
     */
    
    func routeToCategoryItem(data : ShopResponseModel?){
        if let vc = dependencyManager.categoryItembuilder().build() as? CategoryItemViewController {
            vc.modalPresentationStyle = .overFullScreen
            vc.delegate = self.viewController as? HomeViewViewController
            vc.displayModel.categoryItemData = data
            self.viewController?.present(vc, animated: true, completion: nil)
        }
    }
    
    func routeToStore(){
        if let vc = dependencyManager.storeBuilder().build() as? StoreViewController {
            vc.modalPresentationStyle = .overFullScreen
            vc.delegate = self.viewController as? HomeViewViewController
            self.viewController?.present(vc, animated: true, completion: nil)
        }
    }
    
}

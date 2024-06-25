//
//  CategoryItemRouter.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 28/7/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
import Foundation
import UIKit

/// CategoryItemRouter list router. Responsible for navigating from the view.
final class CategoryItemRouter {
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
    func back(){
        self.viewController?.dismiss(animated: true)
    }
    
    func routeToStore(){
        if let vc = dependencyManager.storeBuilder().build() as? StoreViewController {
            vc.modalPresentationStyle = .overFullScreen
            vc.delegate = self.viewController as? CategoryItemViewController
            self.viewController?.present(vc, animated: true, completion: nil)
        }
    }
}

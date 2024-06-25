//
//  SplashRouter.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 23/7/23.
//
import Foundation
import UIKit

/// SplashRouter list router. Responsible for navigating from the view.
final class SplashRouter {
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
    
    func routeToHome(){
            if let vc = dependencyManager.homeBuilder().build() as? HomeViewViewController {
                let nc = UINavigationController(rootViewController: vc)
                nc.modalPresentationStyle = .overFullScreen
                nc.isNavigationBarHidden = true
                self.viewController?.present(nc, animated: true, completion: nil)
            }
    }
}

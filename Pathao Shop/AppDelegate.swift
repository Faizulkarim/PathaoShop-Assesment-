//
//  AppDelegate.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 23/7/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Properties

    /// The app main window.
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    weak var viewController: UIViewController?
    /// The app dependency manager.
    private(set) var dependencyManager: DependencyManager!
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window!.overrideUserInterfaceStyle = .light
        let environment: AppEnvironment = AppEnvironment.bootstrap(rootWindow: window)
        environment.startApp()
        return true
    }
}


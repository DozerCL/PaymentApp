//
//  AppDelegate.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 19-07-21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let paymentServices: PaymentServices = PaymentServicesImpl()
        
        let coordinator: Coordinator = MainCoordinator(paymentServices: paymentServices)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = coordinator.start()
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

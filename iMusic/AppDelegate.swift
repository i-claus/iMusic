//
//  AppDelegate.swift
//  iMusic
//
//  Created by Ricardo Casanova on 23/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private var reachability: Reachability?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureReachability()
        configureNavigationBar()
        showInitialView()
        return true
    }
   
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        handleNetworkChange()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

//MARK: - Navigation methods
extension AppDelegate  {
    
    private func showInitialView() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = SearchListRouter.setupModule()
        self.window?.makeKeyAndVisible()
    }
    
    private func configureNavigationBar() {
        UINavigationBar.appearance().barStyle = .default
        UINavigationBar.appearance().barTintColor = .brown
        UINavigationBar.appearance().tintColor = .white()
        UINavigationBar.appearance().barStyle = .blackOpaque
    }
    
}

//MARK: - Reachability
extension AppDelegate {
    
    private func configureReachability() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNetworkChange), name: NSNotification.Name.reachabilityChanged, object: nil)
        reachability = Reachability.forInternetConnection()
        reachability?.startNotifier()
    }
    
    @objc private func handleNetworkChange() {
        if !ReachabilityManager.shared.hasConnection() {
            showReachabilityMessage(true)
            return
        }
        
        showReachabilityMessage(false)
    }
    
    //Show reachability message
    private func showReachabilityMessage(_ show: Bool) {
        guard let rootViewController = UIApplication.shared.windows[0].rootViewController else {
            return
        }
        
        if show, let _ = rootViewController.presentedViewController as? GeneralMessageViewController {
            return
        }
        
        if show {
            let generalMessageViewController = GeneralMessageViewController()
            generalMessageViewController.modalTransitionStyle = .coverVertical
            generalMessageViewController.modalPresentationStyle = .overCurrentContext
            generalMessageViewController.presenter = GeneralMessagePresenter(view: generalMessageViewController, type: .NoInternetConnection)
            rootViewController.present(generalMessageViewController, animated: true, completion: nil)
        } else {
            rootViewController.dismiss(animated: true, completion: nil)
        }
    }
}






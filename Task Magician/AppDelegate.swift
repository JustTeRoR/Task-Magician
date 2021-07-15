//
//  AppDelegate.swift
//  Task Magician
//
//  Created by Сергей Павленок on 10.07.2021.
//

import UIKit
import VK_ios_sdk

@main
class AppDelegate: UIResponder, UIApplicationDelegate, AuthServiceDelegate {
    var window: UIWindow?
    var authService: AuthService!
    static func shared() -> AppDelegate {
        // swiftlint:disable force_cast
        return UIApplication.shared.delegate as! AppDelegate
        // swiftlint:enable force_cast
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        // Applications are expected to have a root view controller at the end of application launch
        // Application if user logged in enters wake up session afterm that's why exception about no windows
        // Decided for now just giving app delegate empty window until it gets the correct one.
        // bad bad bad, to think about next 3 lines, how to get rid of them and not recieve an error again.
        let authVC: ViewTasksViewController = ViewTasksViewController.loadFromStoryboard()
        let navVC = UINavigationController(rootViewController: authVC)
        window?.rootViewController = navVC
        
        
        self.authService = AuthService()
        authService.delegate = self
        let scope = ["wall", "friends"]
        VKSdk.wakeUpSession(scope) { (state, _) in
            print(state.rawValue)
            if state == VKAuthorizationState.authorized {
            self.authServiceSignIn()
        } else {
            self.authVC()
            }
    }
    return true
}
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String)
        print("url: \(url)")
        return true
    }
    private func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        VKSdk.processOpen(url as URL?, fromApplication: sourceApplication)
        print("url: \(url)")
        return true
    }
    // MARK: AuthServiceDelegate
    func authServiceShouldShow(_ viewController: UIViewController) {
        print(#function)
        window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func authServiceSignIn() {
        print(#function)
        let mainVC: ViewTasksViewController = ViewTasksViewController.loadFromStoryboard()
        let navVC = UINavigationController(rootViewController: mainVC)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
    func authVC() {
        print(#function)
        let authVC: AuthorizeUserViewController = AuthorizeUserViewController.loadFromStoryboard()
        let navVC = UINavigationController(rootViewController: authVC)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
    func authServiceDidSignInFail() {
        print(#function)
    }
}

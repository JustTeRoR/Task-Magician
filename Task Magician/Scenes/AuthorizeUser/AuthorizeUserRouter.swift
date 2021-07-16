//
//  AuthorizeUserRouter.swift
//  Task Magician
//

import UIKit

@objc protocol AuthorizeUserRoutingLogic
{
    func routeToRegister(segue: UIStoryboardSegue?)
    func navigateToRegisterUser(source: AuthorizeUserViewController, destination: RegisterUserViewController)
}

protocol AuthorizeUserDataPassing {
    var dataStore: AuthorizeUserDataStore? { get }
}

class AuthorizeUserRouter: NSObject, AuthorizeUserRoutingLogic, AuthorizeUserDataPassing {
  weak var viewController: AuthorizeUserViewController?
  var dataStore: AuthorizeUserDataStore?
  // MARK: Routing
    func routeToRegister(segue: UIStoryboardSegue?) {
        if let segue = segue {
            // swiftlint:disable force_cast
            let destinationVC = segue.destination as! RegisterUserViewController
        } else {
            let storyboard = UIStoryboard(name: "AuthorizeUser", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "RegisterUserViewController") as! RegisterUserViewController
            // swiftlint:enable force_cast
            navigateToRegisterUser(source: viewController!, destination: destinationVC)
        }
    }

  // MARK: Navigation
    func navigateToRegisterUser(source: AuthorizeUserViewController, destination: RegisterUserViewController) {
        source.show(destination, sender: nil)
    }
  // MARK: Passing data
  //func passDataToSomewhere(source: AuthorizeUserDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}

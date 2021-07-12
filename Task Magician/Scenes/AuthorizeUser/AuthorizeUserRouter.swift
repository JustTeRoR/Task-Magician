//
//  AuthorizeUserRouter.swift
//  Task Magician
//

import UIKit

@objc protocol AuthorizeUserRoutingLogic
{
  // func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol AuthorizeUserDataPassing
{
  var dataStore: AuthorizeUserDataStore? { get }
}

class AuthorizeUserRouter: NSObject, AuthorizeUserRoutingLogic, AuthorizeUserDataPassing {
  weak var viewController: AuthorizeUserViewController?
  var dataStore: AuthorizeUserDataStore?
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: AuthorizeUserViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: AuthorizeUserDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}

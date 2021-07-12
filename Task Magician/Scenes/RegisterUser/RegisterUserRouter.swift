//
//  RegisterUserRouter.swift
//  Task Magician
//

import UIKit

@objc protocol RegisterUserRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol RegisterUserDataPassing
{
  var dataStore: RegisterUserDataStore? { get }
}

class RegisterUserRouter: NSObject, RegisterUserRoutingLogic, RegisterUserDataPassing
{
  weak var viewController: RegisterUserViewController?
  var dataStore: RegisterUserDataStore?
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
  
  //func navigateToSomewhere(source: RegisterUserViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: RegisterUserDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}

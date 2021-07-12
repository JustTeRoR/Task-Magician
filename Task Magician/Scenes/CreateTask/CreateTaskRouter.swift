//
//  CreateTaskRouter.swift
//  Task Magician
//
//  Created by Сергей Павленок on 12.07.2021.
//

import UIKit

@objc protocol CreateTaskRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol CreateTaskDataPassing
{
  var dataStore: CreateTaskDataStore? { get }
}

class CreateTaskRouter: NSObject, CreateTaskRoutingLogic, CreateTaskDataPassing
{
  weak var viewController: CreateTaskViewController?
  var dataStore: CreateTaskDataStore?
  
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
  
  //func navigateToSomewhere(source: CreateTaskViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: CreateTaskDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}

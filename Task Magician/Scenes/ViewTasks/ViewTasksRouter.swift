//
//  ViewTasksRouter.swift
//  Task Magician
//
//  Created by Сергей Павленок on 13.07.2021.
//

import UIKit

@objc protocol ViewTasksRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ViewTasksDataPassing
{
  var dataStore: ViewTasksDataStore? { get }
}

class ViewTasksRouter: NSObject, ViewTasksRoutingLogic, ViewTasksDataPassing
{
  weak var viewController: ViewTasksViewController?
  var dataStore: ViewTasksDataStore?
  
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
  
  //func navigateToSomewhere(source: ViewTasksViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: ViewTasksDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}

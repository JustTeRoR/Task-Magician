//
//  ViewTasksViewController+searchBar.swift
//  Task Magician
//
//  Created by Сергей Павленок on 20.07.2021.
//

import UIKit

extension ViewTasksViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !filtering {
            searchedTasks = tasks.filter({ (task) in
                return task.name.lowercased().contains(searchText.lowercased())
            })
        } else {
            filteredTasks = filteredTasks.filter({ (task) in
                return task.name.lowercased().contains(searchText.lowercased())
            })
        }
        searching = true
        tasksTable.reloadData()
        
        if searchText == "" {
            searching = false
            searchBar.resignFirstResponder()
            applySearchingCriteria(criteria: self.filterCriteria)
            tasksTable.reloadData()
        }
    }
}

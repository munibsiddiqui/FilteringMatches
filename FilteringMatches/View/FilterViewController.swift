//
//  FilterViewController.swift
//  FilteringMatches
//
//  Created by Gaditek on 16/07/2019.
//  Copyright © 2019 Munib Siddiqui. All rights reserved.
//

import UIKit

protocol FilterViewControllerDelegate: class {
    
    func filterViewController(_ controller: FilterViewController, didSelect filter: UserFilter)
    func filterViewController(_ controller: FilterViewController, didDeselect filter: UserFilter)
    func filterViewControllerDidClearFilters(controller: FilterViewController)
    
}

class FilterViewController: UITableViewController {

    weak var delegate: FilterViewControllerDelegate?
    let filters = UserFilter.defaultFilters

    var selectedFilters: Set<UserFilter> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
}


extension FilterViewController  {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return filters.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters[section].filters.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filters[section].title
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let filter = filters[indexPath.section].filters[indexPath.row]
        if selectedFilters.contains(filter) {
            selectedFilters.remove(filter)
            delegate?.filterViewController(self, didDeselect: filter)
        } else {
            selectedFilters.insert(filter)
            delegate?.filterViewController(self, didSelect: filter)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let filter = filters[indexPath.section].filters[indexPath.row]
        
        switch filter {
        case .photo(_, let name):
            cell.textLabel?.text = name

        case .contact(_, let name):
            cell.textLabel?.text = name
        }
        
        if selectedFilters.contains(filter) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
}

//
//  ViewController.swift
//  FilteringMatches
//
//  Created by Gaditek on 17/07/2019.
//  Copyright © 2019 Munib Siddiqui. All rights reserved.
//

import UIKit

class UserListViewController: UITableViewController {

    private var viewModel = MatchesViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        self.tableView.delegate = viewModel
        self.tableView.dataSource = viewModel
        
        viewModel.fetchAllMatches {
            
            DispatchQueue.main.async {
               self.tableView.reloadData()
            }

        }
    }


    private func filterUsers(userFilters: [UserFilter]) {
        
        viewModel.filterUsers(filter: userFilters) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

    }
    
    
    @IBAction func filter(_ sender: Any) {
        
    let filterViewController:FilterViewController = self.storyboard!.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        filterViewController.delegate = self
        self.navigationController?.pushViewController(filterViewController, animated: true)
    }
    
}


extension UserListViewController : FilterViewControllerDelegate {
    
    func filterViewController(_ controller: FilterViewController, didSelect filter: UserFilter) {
        
        filterUsers(userFilters: Array(controller.selectedFilters))
    }
    
    func filterViewController(_ controller: FilterViewController, didDeselect filter: UserFilter) {
        filterUsers(userFilters: Array(controller.selectedFilters))
    }
    
    func filterViewControllerDidClearFilters(controller: FilterViewController) {
        
    }
}

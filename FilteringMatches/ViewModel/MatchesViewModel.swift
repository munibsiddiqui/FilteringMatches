//
//  MatchesViewModel.swift
//  FilteringMatches
//
//  Created by Gaditek on 17/07/2019.
//  Copyright © 2019 Munib Siddiqui. All rights reserved.
//

import Foundation
import UIKit

class MatchesViewModel: NSObject {
    
    var users: [User] = []
    var filteredUsers: [User] = []

    var error: Error?
    let imageLoader = ImageCacheLoader()
    
    override init() {
        super.init()
        
    }
    
    func fetchAllMatches(completion: @escaping () -> Void) {
        
        NetworkManager.sharedInstance.getAllUser(onSuccess: { (users) in
            self.users = users
            self.filteredUsers = self.users
            completion()
            
        }) { (error) in
            self.error = error
            completion()
            
        }
        
    }
    
    func filterUsers(filter:[UserFilter],completion: @escaping () -> Void)
    {
        self.filteredUsers = self.users.filter(with: filter.photoFilter).filter(with: filter.contactFilters)
        completion()
    }
}

// MARK: - UITableViewDataSource

extension MatchesViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.filteredUsers.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath)
            as! UserTableViewCell
        let user  = self.filteredUsers[indexPath.row]
        
        cell.displayNameLabel.text = user.displayName
        cell.religionLabel.text = user.religion
        cell.tag = indexPath.row

        if let userPhoto = user.mainPhoto {
            
            imageLoader.obtainImageWithPath(imagePath: userPhoto) { (image) in
                
                if cell.tag == indexPath.row
                {
                    cell.photoImageView.image = image
                }
            }
        }else {
            cell.photoImageView.image = UIImage(named: "placeholder")
        }

        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension MatchesViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
}


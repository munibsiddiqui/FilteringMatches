//
//  UserFilter.swift
//  FilteringMatches
//
//  Created by Gaditek on 17/07/2019.
//  Copyright © 2019 Munib Siddiqui. All rights reserved.
//

import Foundation

enum UserFilter: Hashable {
    
    case photo(value: Bool, name: String);
    case contact(value: Bool, name: String);
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .photo(value: let value, name: let name):
            hasher.combine("\(value)-\(name)")
        case .contact(value: let value, name: let name):
            hasher.combine("\(value)-\(name)")
        }
    }
    
    
}

extension UserFilter {
    
    static var defaultFilters:[(title: String, filters: [UserFilter])] = [
        ("Photo", [
            .photo(value: true, name: "Have Photo"),
            .photo(value: false, name: "Does not have Photo"),
            ]),
        ("Contacts", [
            .contact(value: true, name: "Have Contact"),
            .contact(value: false, name: "Does not have Contact"),
            ])
    ]
    
}

extension Array where Element == UserFilter {
    
    var photoFilter: [Element] {
        return filter {
            if case .photo(_) = $0 {
                return true
            } else {
                return false
            }
        }
    }
    
    var contactFilters: [Element] {
        return filter {
            if case .contact(_) = $0 {
                return true
            } else {
                return false
            }
        }
        
    }
    
}

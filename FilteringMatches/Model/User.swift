//
//  User.swift
//  FilteringMatches
//
//  Created by Gaditek on 17/07/2019.
//  Copyright © 2019 Munib Siddiqui. All rights reserved.
//

import Foundation


// MARK: - User
struct User: Codable {
    let displayName: String?
    let age: Int?
    let jobTitle: String?
    let heightInCM: Int?
    let city: City?
    let mainPhoto: String?
    let compatibilityScore: Double?
    let contactsExchanged: Int?
    let favourite: Bool?
    let religion: String?
    
    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case age
        case jobTitle = "job_title"
        case heightInCM = "height_in_cm"
        case city
        case mainPhoto = "main_photo"
        case compatibilityScore = "compatibility_score"
        case contactsExchanged = "contacts_exchanged"
        case favourite, religion
    }
}

// MARK: User convenience initializers and mutators

extension User {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(User.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        displayName: String?? = nil,
        age: Int?? = nil,
        jobTitle: String?? = nil,
        heightInCM: Int?? = nil,
        city: City?? = nil,
        mainPhoto: String?? = nil,
        compatibilityScore: Double?? = nil,
        contactsExchanged: Int?? = nil,
        favourite: Bool?? = nil,
        religion: String?? = nil
        ) -> User {
        return User(
            displayName: displayName ?? self.displayName,
            age: age ?? self.age,
            jobTitle: jobTitle ?? self.jobTitle,
            heightInCM: heightInCM ?? self.heightInCM,
            city: city ?? self.city,
            mainPhoto: mainPhoto ?? self.mainPhoto,
            compatibilityScore: compatibilityScore ?? self.compatibilityScore,
            contactsExchanged: contactsExchanged ?? self.contactsExchanged,
            favourite: favourite ?? self.favourite,
            religion: religion ?? self.religion
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - City
struct City: Codable {
    let name: String?
    let lat, lon: Double?
}

// MARK: City convenience initializers and mutators

extension City {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(City.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        name: String?? = nil,
        lat: Double?? = nil,
        lon: Double?? = nil
        ) -> City {
        return City(
            name: name ?? self.name,
            lat: lat ?? self.lat,
            lon: lon ?? self.lon
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}


extension Array where Element == User {
    
    func filter(with usersFilter: [UserFilter]) -> [Element] {
        if usersFilter.isEmpty { return self }
        
        return self.filter() { (user) -> Bool in
            return usersFilter.first { (filter) -> Bool in
                switch filter {
                    
                case .photo(let value, _):
                    return value ? user.mainPhoto?.count ?? -1 > 0 : (user.mainPhoto == nil || user.mainPhoto!.isEmpty)
                    
                case .contact(let value, _):
                    return value ? user.contactsExchanged! > 0 : (user.contactsExchanged! == 0)
                }
                } != nil
        }
    }
}

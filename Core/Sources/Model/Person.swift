//
//  Person.swift
//  Core
//
//  Created by Mariusz Sut on 03/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation

public struct Person {
    public let companyName: String
    public let firstName: String
    public let lastName: String
    public let pesel: String
    public let nip: String
    
    public init(companyName: String,
                firstName: String,
                lastName: String,
                pesel: String,
                nip: String) {
        self.companyName = companyName
        self.firstName = firstName
        self.lastName = lastName
        self.pesel = pesel
        self.nip = nip
    }
}

extension Person: Codable {
    enum CodingKeys: String, CodingKey {
        case companyName
        case firstName
        case lastName
        case pesel
        case nip
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        companyName = try container.decodeIfPresent(String.self, forKey: .companyName) ?? ""
        firstName = try container.decodeIfPresent(String.self, forKey: .firstName) ?? ""
        lastName = try container.decodeIfPresent(String.self, forKey: .lastName) ?? ""
        pesel = try container.decodeIfPresent(String.self, forKey: .pesel) ?? ""
        nip = try container.decodeIfPresent(String.self, forKey: .nip) ?? ""
    }
}

extension Person: Equatable {}

extension Person: Hashable {}

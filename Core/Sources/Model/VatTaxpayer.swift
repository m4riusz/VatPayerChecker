//
//  VatTaxpayer.swift
//  Core
//
//  Created by Mariusz Sut on 03/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation

public struct VatTaxpayer {
    public let name: String
    public let nip: String
    public let vatStatus: VatStatus?
    public let regon: String
    public let pesel: String
    public let krs: String
    public let residenceAddress: String
    public let workingAddress: String
    public let representatives: [Person]
    public let authorizedClerks: [Person]
    public let partners: [Person]
    public let registrationLegalDate: Date?
    public let registrationDenialDate: Date?
    public let registrationDenialBasis: String?
    public let restorationDate: Date?
    public let restorationBasis: String?
    public let removalDate: Date?
    public let removalBasis: String?
    public let accountNumbers: [String]
    public let hasVirtualAccounts: Bool?
    
    public init(name: String,
                nip: String,
                vatStatus: VatStatus?,
                regon: String,
                pesel: String,
                krs: String,
                residenceAddress: String,
                workingAddress: String,
                representatives: [Person],
                authorizedClerks: [Person],
                partners: [Person],
                registrationLegalDate: Date?,
                registrationDenialDate: Date?,
                registrationDenialBasis: String?,
                restorationDate: Date?,
                restorationBasis: String?,
                removalDate: Date?,
                removalBasis: String?,
                accountNumbers: [String],
                hasVirtualAccounts: Bool?) {
        self.name = name
        self.nip = nip
        self.vatStatus = vatStatus
        self.regon = regon
        self.pesel = pesel
        self.krs = krs
        self.residenceAddress = residenceAddress
        self.workingAddress = workingAddress
        self.representatives = representatives
        self.authorizedClerks = authorizedClerks
        self.partners = partners
        self.registrationLegalDate = registrationLegalDate
        self.registrationDenialDate = registrationDenialDate
        self.registrationDenialBasis = registrationDenialBasis
        self.restorationDate = restorationDate
        self.restorationBasis = restorationBasis
        self.removalDate = removalDate
        self.removalBasis = removalBasis
        self.accountNumbers = accountNumbers
        self.hasVirtualAccounts =  hasVirtualAccounts
    }
}

extension VatTaxpayer: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case nip
        case vatStatus = "statusVat"
        case regon
        case pesel
        case krs
        case residenceAddress
        case workingAddress
        case representatives
        case authorizedClerks
        case partners
        case registrationLegalDate
        case registrationDenialDate
        case registrationDenialBasis
        case restorationDate
        case restorationBasis
        case removalDate
        case removalBasis
        case accountNumbers
        case hasVirtualAccounts
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        nip = try container.decodeIfPresent(String.self, forKey: .nip) ?? ""
        vatStatus = try container.decodeIfPresent(VatStatus.self, forKey: .vatStatus)
        regon = try container.decodeIfPresent(String.self, forKey: .regon) ?? ""
        pesel = try container.decodeIfPresent(String.self, forKey: .pesel) ?? ""
        krs = try container.decodeIfPresent(String.self, forKey: .krs) ?? ""
        residenceAddress = try container.decodeIfPresent(String.self, forKey: .residenceAddress) ?? ""
        workingAddress = try container.decodeIfPresent(String.self, forKey: .workingAddress) ?? ""
        representatives = try container.decodeIfPresent([Person].self, forKey: .representatives) ?? []
        authorizedClerks = try container.decodeIfPresent([Person].self, forKey: .authorizedClerks) ?? []
        partners = try container.decodeIfPresent([Person].self, forKey: .partners) ?? []
        registrationLegalDate = try container.decodeIfPresent(Date.self, forKey: .registrationLegalDate)
        registrationDenialDate = try container.decodeIfPresent(Date.self, forKey: .registrationDenialDate)
        registrationDenialBasis = try container.decodeIfPresent(String.self, forKey: .registrationDenialBasis) ?? ""
        restorationDate = try container.decodeIfPresent(Date.self, forKey: .restorationDate)
        restorationBasis = try container.decodeIfPresent(String.self, forKey: .restorationBasis) ?? ""
        removalDate = try container.decodeIfPresent(Date.self, forKey: .removalDate)
        removalBasis = try container.decodeIfPresent(String.self, forKey: .removalBasis) ?? ""
        accountNumbers = try container.decodeIfPresent([String].self, forKey: .accountNumbers) ?? []
        hasVirtualAccounts = try container.decodeIfPresent(Bool.self, forKey: .hasVirtualAccounts)
    }
}

extension VatTaxpayer: Equatable {}

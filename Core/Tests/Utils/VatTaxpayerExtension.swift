//
//  VatTaxpayerExtension.swift
//  CoreTest
//
//  Created by Mariusz Sut on 16/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation

extension VatTaxpayer {
    static func stub(name: String) -> VatTaxpayer {
        VatTaxpayer(name: name,
                    nip: "nip",
                    vatStatus: nil,
                    regon: "regon",
                    pesel: "pesel",
                    krs: "krs",
                    residenceAddress: "residenceAddress",
                    workingAddress: "workingAddress",
                    representatives: [],
                    authorizedClerks: [],
                    partners: [],
                    registrationLegalDate: nil,
                    registrationDenialDate: nil,
                    registrationDenialBasis: nil,
                    restorationDate: nil,
                    restorationBasis: nil,
                    removalDate: nil,
                    removalBasis: nil,
                    accountNumbers: [],
                    hasVirtualAccounts: nil)
    }
}

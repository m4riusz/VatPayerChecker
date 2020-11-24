//
//  VatTaxpayerSearchState.swift
//  VatPayerChecker
//
//  Created by Mariusz Sut on 14/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import Core

enum VatTaxpayerLoadable {
    case ready
    case loading
    case success(_ vatTaxpayer: VatTaxpayer)
    case error(_ error: VatError)
}

struct VatTaxpayerSearchState: StateRedux {
    var searchQuery = ""
    var searchDate = Date()
    var searchOption: VatTaxpayerSearchBar.Option = .nip
    var status: VatTaxpayerLoadable = .success(
        VatTaxpayer(name: "Company name",
                    nip: "25423152135",
                    vatStatus: .active,
                    regon: "regon",
                    pesel: "pesel",
                    krs: "krs",
                    residenceAddress: "residenceAddress",
                    workingAddress: "workingAddress",
                    representatives: [Person(companyName: "company name",
                                             firstName: "First name",
                                             lastName: "last name",
                                             pesel: "pesel",
                                             nip: "nip")],
                    authorizedClerks: [Person(companyName: "company name",
                                              firstName: "First name",
                                              lastName: "last name",
                                              pesel: "pesel",
                                              nip: "nip"),
                                       Person(companyName: "company name",
                                                                firstName: "First name",
                                                                lastName: "last name",
                                                                pesel: "pesel",
                                                                nip: "nip")],
                    partners: [Person(companyName: "company name",
                                      firstName: "First name",
                                      lastName: "last name",
                                      pesel: "pesel",
                                      nip: "nip")],
                    registrationLegalDate: Date(),
                    registrationDenialDate: Date(),
                    registrationDenialBasis: "registrationDenialBasis",
                    restorationDate: Date(),
                    restorationBasis: "restorationBasis",
                    removalDate: Date(),
                    removalBasis: "removalBasis",
                    accountNumbers: ["11111212121212","11111212121212","11111212121212"],
                    hasVirtualAccounts: nil)
    )
}

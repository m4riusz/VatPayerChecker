//
//  VatTaxpayerView.swift
//  MobileApp
//
//  Created by Mariusz Sut on 20/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI
import Core

struct VatTaxpayerView: View {
    private typealias Literals = MobileAppStrings
    let vatTaxpayer: VatTaxpayer
    
    var body: some View {
        List {
            Group {
                nameSection
                nipSection
                vatStatusSection
                regonSection
                peselSection
                krsSection
                residenceAddressSection
                workingAddressSection
                representativesSection
                authorizedClerksSection
            }
            Group {
                partnersSection
                registrationLegalDateSection
                registrationDenialDateSection
                registrationDenialBasisSection
                restorationDateSection
                restorationBasisSection
                removalDateSection
                removalBasisSection
                accountNumbersSection
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var nameSection: VatTaxpayerTextRow? {
        createTextRow(title: Literals.name, values: [vatTaxpayer.name])
    }
    
    private var nipSection: VatTaxpayerTextRow? {
        createTextRow(title: Literals.nip, values: [vatTaxpayer.nip])
    }
    
    private var vatStatusSection: VatTaxpayerTextRow? {
        guard let status = vatTaxpayer.vatStatus else { return nil }
        switch status {
        case .active:
            return createTextRow(title: Literals.vatStatus, values: [Literals.vatStatusActive])
        case .exempt:
            return createTextRow(title: Literals.vatStatus, values: [Literals.vatStatusExempt])
        case .notRegistered:
            return createTextRow(title: Literals.vatStatus, values: [Literals.vatStatusNotRegistered])
        }
    }
    
    private var regonSection: VatTaxpayerTextRow? {
        createTextRow(title: Literals.regon, values: [vatTaxpayer.regon])
    }
    
    private var peselSection: VatTaxpayerTextRow? {
        createTextRow(title: Literals.pesel, values: [vatTaxpayer.pesel])
    }
    
    private var krsSection: VatTaxpayerTextRow? {
        createTextRow(title: Literals.krs, values: [vatTaxpayer.krs])
    }
    
    private var residenceAddressSection: VatTaxpayerTextRow? {
        createTextRow(title: Literals.residenceAddress, values: [vatTaxpayer.residenceAddress])
    }
    
    private var workingAddressSection: VatTaxpayerTextRow? {
        createTextRow(title: Literals.workingAddress, values: [vatTaxpayer.workingAddress])
    }
    
    private var representativesSection: VatTaxpayerPersonRow? {
        createPersonRow(title: Literals.representatives, persons: vatTaxpayer.representatives)
    }
    
    private var authorizedClerksSection: VatTaxpayerPersonRow? {
        createPersonRow(title: Literals.authorizedClerks, persons: vatTaxpayer.authorizedClerks)
    }
    
    private var partnersSection: VatTaxpayerPersonRow? {
        createPersonRow(title: Literals.partners, persons: vatTaxpayer.partners)
    }
    
    private var registrationLegalDateSection: VatTaxpayerTextRow? {
        createTextRow(title: Literals.registrationLegalDate, values: [vatTaxpayer.registrationLegalDate?.yyyyMMdd])
    }
    
    private var registrationDenialDateSection: VatTaxpayerTextRow? {
        createTextRow(title: Literals.registrationDenialDate, values: [vatTaxpayer.registrationDenialDate?.yyyyMMdd])
    }
    
    private var registrationDenialBasisSection: VatTaxpayerTextRow? {
        createTextRow(title: Literals.registrationDenialBasis, values: [vatTaxpayer.registrationDenialBasis])
    }
    
    private var restorationDateSection: VatTaxpayerTextRow? {
        createTextRow(title: Literals.restorationDate, values: [vatTaxpayer.restorationDate?.yyyyMMdd])
    }
    
    private var restorationBasisSection: VatTaxpayerTextRow? {
        createTextRow(title: Literals.restorationBasis, values: [vatTaxpayer.restorationBasis])
    }
    
    private var removalDateSection: VatTaxpayerTextRow? {
        createTextRow(title: Literals.removalDate, values: [vatTaxpayer.removalDate?.yyyyMMdd])
    }
    
    private var removalBasisSection: VatTaxpayerTextRow? {
        createTextRow(title: Literals.removalBasis, values: [vatTaxpayer.removalBasis])
    }
    
    private var accountNumbersSection: VatTaxpayerTextRow? {
        createTextRow(title: Literals.accountNumbers, values: vatTaxpayer.accountNumbers)
    }
    
    private func createTextRow(title: String, values: [String?]) -> VatTaxpayerTextRow? {
        let notNilAndEmptyValues = values
            .filter { !$0.isNilOrEmpty }
            .compactMap { $0 }
        
        guard !notNilAndEmptyValues.isEmpty else {
            return nil
        }
        return VatTaxpayerTextRow(title: title, values: notNilAndEmptyValues)
    }
    
    private func createPersonRow(title: String, persons: [Person]) -> VatTaxpayerPersonRow? {
        guard !persons.isEmpty else { return nil }
        return VatTaxpayerPersonRow(title: title, persons: persons)
    }
}

struct VatTaxpayerView_Previews: PreviewProvider {
    static var previews: some View {
        VatTaxpayerView(vatTaxpayer:
                            VatTaxpayer(name: "Januszex",
                                        nip: "582759127",
                                        vatStatus: .active,
                                        regon: "7734235",
                                        pesel: "5298728323",
                                        krs: "1241",
                                        residenceAddress: "ul Papieska 21/37 99-999 Wadowice",
                                        workingAddress: "ul Papieska 21/37 99-999 Wadowice",
                                        representatives: [Person(companyName: "Firma",
                                                                 firstName: "Stanisław",
                                                                 lastName: "Dziwisz",
                                                                 pesel: "52512521",
                                                                 nip: "55309830")],
                                        authorizedClerks: [Person(companyName: "Firma 1",
                                                                  firstName: "Imie 1",
                                                                  lastName: "Nazwisko 1",
                                                                  pesel: "325251252",
                                                                  nip: "452422345"),
                                                           Person(companyName: "Firma 2",
                                                                  firstName: "Imie 2",
                                                                  lastName: "Nazwisko 2",
                                                                  pesel: "09820422",
                                                                  nip: "982095832")],
                                        partners: [Person(companyName: "Person 1 company",
                                                          firstName: "Imie 3",
                                                          lastName: "Nazwisko 3",
                                                          pesel: "324223233",
                                                          nip: "351412412")],
                                        registrationLegalDate: Date(),
                                        registrationDenialDate: Date(),
                                        registrationDenialBasis: "registrationDenialBasis",
                                        restorationDate: Date(),
                                        restorationBasis: "restorationBasis",
                                        removalDate: Date(),
                                        removalBasis: "removalBasis",
                                        accountNumbers: ["12112123123121241241212", "2312342423423423"],
                                        hasVirtualAccounts: false))
    }
}

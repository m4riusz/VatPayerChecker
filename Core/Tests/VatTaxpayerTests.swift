//
//  VatTaxpayerTests.swift
//  CoreTests
//
//  Created by Mariusz Sut on 04/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import XCTest
import TestKit

@testable import Core

final class VatTaxpayerTests: BaseTestCase {
    
    override var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.yearMonthDay)
        return decoder
    }
    
    func testDeserializeNoCompanyName() {
        let sut = decodeFromJsonFile(type: VatTaxpayer.self, fileName: "VatTaxpayer_noName")!
        XCTAssertEqual(sut.name, "")
    }
    
    func testDeserializeNoNip() {
        let sut = decodeFromJsonFile(type: VatTaxpayer.self, fileName: "VatTaxpayer_noNip")!
        XCTAssertEqual(sut.nip, "")
    }
    
    func testDeserializeNoVatStatus() {
        let sut = decodeFromJsonFile(type: VatTaxpayer.self, fileName: "VatTaxpayer_noVatStatus")!
        XCTAssertNil(sut.vatStatus)
    }
    
    func testDeserializeNoRegon() {
        let sut = decodeFromJsonFile(type: VatTaxpayer.self, fileName: "VatTaxpayer_noRegon")!
        XCTAssertEqual(sut.regon, "")
    }
    
    func testDeserializeNoPesel() {
        let sut = decodeFromJsonFile(type: VatTaxpayer.self, fileName: "VatTaxpayer_noPesel")!
        XCTAssertEqual(sut.pesel, "")
    }
    
    func testDeserializeNoKrs() {
        let sut = decodeFromJsonFile(type: VatTaxpayer.self, fileName: "VatTaxpayer_noKrs")!
        XCTAssertEqual(sut.krs, "")
    }
    
    func testDeserializeNoResidenceAddress() {
        let sut = decodeFromJsonFile(type: VatTaxpayer.self, fileName: "VatTaxpayer_noResidenceAddress")!
        XCTAssertEqual(sut.residenceAddress, "")
    }
    
    func testDeserializeNoWorkingAddress() {
        let sut = decodeFromJsonFile(type: VatTaxpayer.self, fileName: "VatTaxpayer_noWorkingAddress")!
        XCTAssertEqual(sut.workingAddress, "")
    }
    
    func testDeserializeNoRepresentatives() {
        let sut = decodeFromJsonFile(type: VatTaxpayer.self, fileName: "VatTaxpayer_noRepresentatives")!
        XCTAssertEqual(sut.representatives, [])
    }
    
    func testDeserializeNoAuthorizedClerks() {
        let sut = decodeFromJsonFile(type: VatTaxpayer.self, fileName: "VatTaxpayer_noAuthorizedClerks")!
        XCTAssertEqual(sut.authorizedClerks, [])
    }
    
    func testDeserializeNoPartners() {
        let sut = decodeFromJsonFile(type: VatTaxpayer.self, fileName: "VatTaxpayer_noPartners")!
        XCTAssertEqual(sut.partners, [])
    }
    
    func testDeserializeNoRegistrationLegalDate() {
        let sut = decodeFromJsonFile(type: VatTaxpayer.self, fileName: "VatTaxpayer_noRegistrationLegalDate")!
        XCTAssertNil(sut.registrationLegalDate)
    }
    
    func testDeserializeNoRegistrationDenialDate() {
        let sut = decodeFromJsonFile(type: VatTaxpayer.self, fileName: "VatTaxpayer_noRegistrationDenialDate")!
        XCTAssertNil(sut.registrationDenialDate)
    }
    
    func testDeserializeNoRegistrationDenialBasis() {
        let sut = decodeFromJsonFile(type: VatTaxpayer.self, fileName: "VatTaxpayer_noRegistrationDenialBasis")!
        XCTAssertEqual(sut.registrationDenialBasis, "")
    }
    
    func testDeserializeNoRestorationDate() {
        let sut = decodeFromJsonFile(type: VatTaxpayer.self, fileName: "VatTaxpayer_noRestorationDate")!
        XCTAssertNil(sut.restorationDate)
    }
    
    func testDeserializeNoRestorationBasis() {
        let sut = decodeFromJsonFile(type: VatTaxpayer.self, fileName: "VatTaxpayer_noRestorationBasis")!
        XCTAssertEqual(sut.restorationBasis, "")
    }
    
    func testDeserializeNoRemovalDate() {
        let sut = decodeFromJsonFile(type: VatTaxpayer.self, fileName: "VatTaxpayer_noRemovalDate")!
        XCTAssertNil(sut.removalDate)
    }
    
    func testDeserializeNoRemovalBasis() {
        let sut = decodeFromJsonFile(type: VatTaxpayer.self, fileName: "VatTaxpayer_noRemovalBasis")!
        XCTAssertEqual(sut.removalBasis, "")
    }
    
    func testDeserializeNoAccountNumbers() {
        let sut = decodeFromJsonFile(type: VatTaxpayer.self, fileName: "VatTaxpayer_noAccountNumbers")!
        XCTAssertEqual(sut.accountNumbers, [])
    }
    
    func testDeserializeNoHasVirtualAccounts() {
        let sut = decodeFromJsonFile(type: VatTaxpayer.self, fileName: "VatTaxpayer_noHasVirtualAccounts")!
        XCTAssertNil(sut.hasVirtualAccounts)
    }
    
    func testDeserializeInvalidDateFormats() {
        let sut = decodeFromJsonFile(type: VatTaxpayer.self, fileName: "VatTaxpayer_invalidDateFormats")
        XCTAssertNil(sut)
    }
    
    func testDeserialize() {
        let sut = decodeFromJsonFile(type: VatTaxpayer.self, fileName: "VatTaxpayer")!
        XCTAssertEqual(sut.name, "name")
        XCTAssertEqual(sut.nip, "nip")
        XCTAssertEqual(sut.vatStatus, .active)
        XCTAssertEqual(sut.regon, "regon")
        XCTAssertEqual(sut.pesel, "pesel")
        XCTAssertEqual(sut.krs, "krs")
        XCTAssertEqual(sut.residenceAddress, "residenceAddress")
        XCTAssertEqual(sut.workingAddress, "workingAddress")
        XCTAssertEqual(sut.representatives, [])
        XCTAssertEqual(sut.authorizedClerks, [])
        XCTAssertEqual(sut.partners, [])
        XCTAssertEqual(sut.registrationLegalDate, .from(year: 2020, month: 1, day: 1))
        XCTAssertEqual(sut.registrationDenialDate, .from(year: 2020, month: 2, day: 2))
        XCTAssertEqual(sut.registrationDenialBasis, "registrationDenialBasis")
        XCTAssertEqual(sut.restorationDate, .from(year: 2020, month: 3, day: 3))
        XCTAssertEqual(sut.restorationBasis, "restorationBasis")
        XCTAssertEqual(sut.removalDate, .from(year: 2020, month: 4, day: 4))
        XCTAssertEqual(sut.removalBasis, "removalBasis")
        XCTAssertEqual(sut.accountNumbers, [])
        XCTAssertEqual(sut.hasVirtualAccounts, true)
    }
}

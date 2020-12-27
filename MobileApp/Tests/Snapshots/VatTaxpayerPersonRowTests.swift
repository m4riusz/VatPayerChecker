//
//  VatTaxpayerPersonRowTests.swift
//  MobileAppTests
//
//  Created by Mariusz Sut on 21/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import Core
import TestKit
import SwiftUI
import SnapshotTesting

@testable import MobileApp

final class VatTaxpayerPersonRowTests: BaseTestCase {
    
    func testSingleItem() {
        let sut = ListContainer(view: VatTaxpayerPersonRow(title: "Representatives",
                                                           person: Person(companyName: "Company name",
                                                                          firstName: "First name",
                                                                          lastName: "Last name",
                                                                          pesel: "92111100899",
                                                                          nip: "9382734853")))
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testManyItems() {
        let sut = ListContainer(view: VatTaxpayerPersonRow(title: "Representatives",
                                                           persons: [Person(companyName: "Company name",
                                                                            firstName: "First name",
                                                                            lastName: "Last name",
                                                                            pesel: "92111100899",
                                                                            nip: "9382734853"),
                                                                     Person(companyName: "Company name",
                                                                            firstName: "First name",
                                                                            lastName: "Last name",
                                                                            pesel: "92111100899",
                                                                            nip: "9382734853")]))
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testEmptyCompanyName() {
        let sut = ListContainer(view: VatTaxpayerPersonRow(title: "Representatives",
                                                           person: Person(companyName: "",
                                                                          firstName: "First name",
                                                                          lastName: "Last name",
                                                                          pesel: "92111100899",
                                                                          nip: "9382734853")))
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testEmptyFirstName() {
        let sut = ListContainer(view: VatTaxpayerPersonRow(title: "Representatives",
                                                           person: Person(companyName: "Company name",
                                                                          firstName: "",
                                                                          lastName: "Last name",
                                                                          pesel: "92111100899",
                                                                          nip: "9382734853")))
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testEmptyLastName() {
        let sut = ListContainer(view: VatTaxpayerPersonRow(title: "Representatives",
                                                           person: Person(companyName: "Company name",
                                                                          firstName: "First name",
                                                                          lastName: "",
                                                                          pesel: "92111100899",
                                                                          nip: "9382734853")))
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testEmptyPesel() {
        let sut = ListContainer(view: VatTaxpayerPersonRow(title: "Representatives",
                                                           person: Person(companyName: "Company name",
                                                                          firstName: "First name",
                                                                          lastName: "Last name",
                                                                          pesel: "",
                                                                          nip: "9382734853")))
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testEmptyNip() {
        let sut = ListContainer(view: VatTaxpayerPersonRow(title: "Representatives",
                                                           person: Person(companyName: "Company name",
                                                                          firstName: "First name",
                                                                          lastName: "Last name",
                                                                          pesel: "92111100899",
                                                                          nip: "")))
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testLongTexts() {
        let sut = ListContainer(view: VatTaxpayerPersonRow(title: "Representatives",
                                                           person:
                                                            Person(companyName: "Very long text thas should contains many lines",
                                                                   firstName: "Very long text thas should contains many lines",
                                                                   lastName: "Very long text thas should contains many lines",
                                                                   pesel: "Very long text thas should contains many lines",
                                                                   nip: "Very long text thas should contains many lines")))
        assertSnapshot(matching: sut, as: .image)
    }
}

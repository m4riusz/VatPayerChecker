//
//  PersonTests.swift
//  CoreTests
//
//  Created by Mariusz Sut on 04/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import XCTest
import TestKit

@testable import Core

final class PersonTests: BaseTestCase {
    
    func testDeserializeNoCompanyName() {
        let sut = decodeFromJsonFile(type: Person.self, fileName: "Person_noCompanyName")!
        XCTAssertEqual(sut.companyName, "")
    }
    
    func testDeserializeNoFirstName() {
        let sut = decodeFromJsonFile(type: Person.self, fileName: "Person_noFirstName")!
        XCTAssertEqual(sut.firstName, "")
    }
    
    func testDeserializeNoLastName() {
        let sut = decodeFromJsonFile(type: Person.self, fileName: "Person_noLastName")!
        XCTAssertEqual(sut.lastName, "")
    }
    
    func testDeserializeNoPesel() {
        let sut = decodeFromJsonFile(type: Person.self, fileName: "Person_noPesel")!
        XCTAssertEqual(sut.pesel, "")
    }
    
    func testDeserializeNoNip() {
        let sut = decodeFromJsonFile(type: Person.self, fileName: "Person_noNip")!
        XCTAssertEqual(sut.nip, "")
    }
    
    func testDeserialize() {
        let sut = decodeFromJsonFile(type: Person.self, fileName: "Person")!
        XCTAssertEqual(sut.companyName, "companyName")
        XCTAssertEqual(sut.firstName, "firstName")
        XCTAssertEqual(sut.lastName, "lastName")
        XCTAssertEqual(sut.pesel, "pesel")
        XCTAssertEqual(sut.nip, "nip")
    }
}

//
//  LocalVatPayerCheckerDataSourceTests.swift
//  CoreTests
//
//  Created by Mariusz Sut on 11/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import XCTest
import TestKit
import Combine
import EntwineTest

@testable import Core

final class LocalVatPayerCheckerDataSourceTests: BaseTestCase {
    private lazy var scheduler = TestScheduler()
    private lazy var sut: VatPayerCheckerDataSourceProtocol = LocalVatPayerCheckerDataSource()
    private lazy var date: Date = .now
    private lazy var otherDate: Date = Date().addingTimeInterval(60 * 60 * 24)
    private lazy var stub: ObjectResult<VatTaxpayer> = .init(subject: .stub(name: "StubTaxPayer"),
                                                             requestDateTime: "10-10-2020",
                                                             requestId: "123456789")
    
    func testNipNotSaved() {
        let nip = sut.getByNip("nip", date: date)
        let nipResult = scheduler.createTestableSubscriber(ObjectResult<VatTaxpayer>.self, VatError.self)
        
        nip.receive(subscriber: nipResult)
        scheduler.resume()
        
        XCTAssertEqual(nipResult.recordedOutput, [
            (0, .subscription),
            (0, .completion(.failure(.invalidNip)))
        ])
    }
    
    func testAccountNotSaved() {
        let account = sut.getByAccountNumber("accountNumber", date: date)
        let accountResult = scheduler.createTestableSubscriber(ObjectResult<VatTaxpayer>.self, VatError.self)
        
        account.receive(subscriber: accountResult)
        scheduler.resume()
        
        XCTAssertEqual(accountResult.recordedOutput, [
            (0, .subscription),
            (0, .completion(.failure(.invalidAccount)))
        ])
    }
    
    func testRegonNotSaved() {
        let regon = sut.getByRegon("regon", date: date)
        let regonResult = scheduler.createTestableSubscriber(ObjectResult<VatTaxpayer>.self, VatError.self)
        
        regon.receive(subscriber: regonResult)
        scheduler.resume()
        
        XCTAssertEqual(regonResult.recordedOutput, [
            (0, .subscription),
            (0, .completion(.failure(.invalidRegon)))
        ])
    }
    
    func testNipSaved() {
        _ = sut.save("nip", date: date, result: stub)
        let nip = sut.getByNip("nip", date: date)
        let nipResult = scheduler.createTestableSubscriber(ObjectResult<VatTaxpayer>.self, VatError.self)
        
        nip.receive(subscriber: nipResult)
        scheduler.resume()
        
        XCTAssertEqual(nipResult.recordedOutput, [
            (0, .subscription),
            (0, .input(stub)),
            (0, .completion(.finished))
        ])
    }
    
    func testAccountSaved() {
        _ = sut.save("accountNumber", date: date, result: stub)
        let account = sut.getByAccountNumber("accountNumber", date: date)
        let accountResult = scheduler.createTestableSubscriber(ObjectResult<VatTaxpayer>.self, VatError.self)
        
        account.receive(subscriber: accountResult)
        scheduler.resume()
        
        XCTAssertEqual(accountResult.recordedOutput, [
            (0, .subscription),
            (0, .input(stub)),
            (0, .completion(.finished))
        ])
    }
    
    func testRegonSaved() {
        _ = sut.save("regon", date: date, result: stub)
        let regon = sut.getByRegon("regon", date: date)
        let regonResult = scheduler.createTestableSubscriber(ObjectResult<VatTaxpayer>.self, VatError.self)
        
        regon.receive(subscriber: regonResult)
        scheduler.resume()
        
        XCTAssertEqual(regonResult.recordedOutput, [
            (0, .subscription),
            (0, .input(stub)),
            (0, .completion(.finished))
        ])
    }
    
    func testDifferentDateNipSaved() {
        _ = sut.save("nip", date: date, result: stub)
        let nip = sut.getByNip("nip", date: otherDate)
        let nipResult = scheduler.createTestableSubscriber(ObjectResult<VatTaxpayer>.self, VatError.self)
        
        nip.receive(subscriber: nipResult)
        scheduler.resume()
        
        XCTAssertEqual(nipResult.recordedOutput, [
            (0, .subscription),
            (0, .completion(.failure(.invalidNip)))
        ])
    }
    
    func testDifferentDateAccountSaved() {
        _ = sut.save("accountNumber", date: date, result: stub)
        let account = sut.getByAccountNumber("accountNumber", date: otherDate)
        let accountResult = scheduler.createTestableSubscriber(ObjectResult<VatTaxpayer>.self, VatError.self)
        
        account.receive(subscriber: accountResult)
        scheduler.resume()
        
        XCTAssertEqual(accountResult.recordedOutput, [
            (0, .subscription),
            (0, .completion(.failure(.invalidAccount)))
        ])
    }
    
    func testDifferentDateRegonSaved() {
        _ = sut.save("regon", date: date, result: stub)
        let regon = sut.getByRegon("regon", date: otherDate)
        let regonResult = scheduler.createTestableSubscriber(ObjectResult<VatTaxpayer>.self, VatError.self)
        
        regon.receive(subscriber: regonResult)
        scheduler.resume()
        
        XCTAssertEqual(regonResult.recordedOutput, [
            (0, .subscription),
            (0, .completion(.failure(.invalidRegon)))
        ])
    }
    
    func testDifferentNipSaved() {
        _ = sut.save("nip", date: date, result: stub)
        let nip = sut.getByNip("otherNip", date: date)
        let nipResult = scheduler.createTestableSubscriber(ObjectResult<VatTaxpayer>.self, VatError.self)
        
        nip.receive(subscriber: nipResult)
        scheduler.resume()
        
        XCTAssertEqual(nipResult.recordedOutput, [
            (0, .subscription),
            (0, .completion(.failure(.invalidNip)))
        ])
    }
    
    func testDifferentAccountSaved() {
        _ = sut.save("accountNumber", date: date, result: stub)
        let account = sut.getByAccountNumber("otherAccountNumber", date: date)
        let accountResult = scheduler.createTestableSubscriber(ObjectResult<VatTaxpayer>.self, VatError.self)
        
        account.receive(subscriber: accountResult)
        scheduler.resume()
        
        XCTAssertEqual(accountResult.recordedOutput, [
            (0, .subscription),
            (0, .completion(.failure(.invalidAccount)))
        ])
    }
    
    func testDifferentRegonSaved() {
        _ = sut.save("regon", date: date, result: stub)
        let regon = sut.getByRegon("otherRegon", date: date)
        let regonResult = scheduler.createTestableSubscriber(ObjectResult<VatTaxpayer>.self, VatError.self)
        
        regon.receive(subscriber: regonResult)
        scheduler.resume()
        
        XCTAssertEqual(regonResult.recordedOutput, [
            (0, .subscription),
            (0, .completion(.failure(.invalidRegon)))
        ])
    }
}

//
//  VatPayerCheckerRepositoryTests.swift
//  CoreTests
//
//  Created by Mariusz Sut on 16/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import XCTest
import TestKit
import Combine
import EntwineTest

@testable import Core

final class VatPayerCheckerRepositoryTests: BaseTestCase {
    private lazy var scheduler = TestScheduler()
    private lazy var stub: VatTaxpayer = .stub(name: "Stub")
    private lazy var date: Date = .now
    private lazy var localDataSource = StubVatPayerCheckerDataSource()
    private lazy var remoteDataSource = StubVatPayerCheckerDataSource()
    private lazy var sut: VatPayerCheckerRepositoryProtocol = {
        VatPayerCheckerRepository(local: localDataSource, remote: remoteDataSource)
    }()
    
    func testGetByNipUnavailableLocalUnavailableRemote() {
        localDataSource.getByNipResult = .failure(.invalidNip)
        remoteDataSource.getByNipResult = .failure(.invalidNip)
        
        let nip = sut.getByNip("nip", date: date)
        let result = scheduler.createTestableSubscriber(VatTaxpayer.self, VatError.self)
        nip.receive(subscriber: result)
        
        scheduler.resume()
        XCTAssertEqual(result.recordedOutput, [
            (0, .subscription),
            (0, .completion(.failure(.invalidNip)))
        ])
    }
    
    func testGetByNipUnavailableLocalAvailableRemote() {
        localDataSource.getByNipResult = .failure(.invalidNip)
        localDataSource.saveResult = .success(stub)
        remoteDataSource.getByNipResult = .success(stub)
        
        let nip = sut.getByNip("nip", date: date)
        let result = scheduler.createTestableSubscriber(VatTaxpayer.self, VatError.self)
        nip.receive(subscriber: result)
        
        scheduler.resume()
        XCTAssertEqual(result.recordedOutput, [
            (0, .subscription),
            (0, .input(stub)),
            (0, .completion(.finished))
        ])
    }
    
    func testGetByNipAvailableLocalUnavailableRemote() {
        localDataSource.getByNipResult = .success(stub)
        
        let nip = sut.getByNip("nip", date: date)
        let result = scheduler.createTestableSubscriber(VatTaxpayer.self, VatError.self)
        nip.receive(subscriber: result)
        
        scheduler.resume()
        XCTAssertEqual(result.recordedOutput, [
            (0, .subscription),
            (0, .input(stub)),
            (0, .completion(.finished))
        ])
    }
    
    func testGetByNipAvailableLocalAvailableRemote() {
        localDataSource.getByNipResult = .success(stub)
        remoteDataSource.getByNipResult = .success(stub)
        
        let nip = sut.getByNip("nip", date: date)
        let result = scheduler.createTestableSubscriber(VatTaxpayer.self, VatError.self)
        nip.receive(subscriber: result)
        
        scheduler.resume()
        XCTAssertEqual(result.recordedOutput, [
            (0, .subscription),
            (0, .input(stub)),
            (0, .completion(.finished))
        ])
    }
    
    func testGetByNipAvailableUnavailableLocalAvailableRemoteSaveFail() {
        localDataSource.getByNipResult = .failure(.invalidNip)
        localDataSource.saveResult = .failure(.unknown)
        remoteDataSource.getByNipResult = .success(stub)
        
        let account = sut.getByNip("nip", date: date)
        let result = scheduler.createTestableSubscriber(VatTaxpayer.self, VatError.self)
        account.receive(subscriber: result)
        
        scheduler.resume()
        XCTAssertEqual(result.recordedOutput, [
            (0, .subscription),
            (0, .completion(.failure(.unknown)))
        ])
    }
    
    func testGetByAccountNumberUnavailableLocalUnavailableRemote() {
        localDataSource.getByAccountNumberResult = .failure(.invalidAccount)
        remoteDataSource.getByAccountNumberResult = .failure(.invalidAccount)
        
        let account = sut.getByAccountNumber("accountNumber", date: date)
        let result = scheduler.createTestableSubscriber(VatTaxpayer.self, VatError.self)
        account.receive(subscriber: result)
        
        scheduler.resume()
        XCTAssertEqual(result.recordedOutput, [
            (0, .subscription),
            (0, .completion(.failure(.invalidAccount)))
        ])
    }
    
    func testGetByAccountNumberUnavailableLocalAvailableRemote() {
        localDataSource.getByAccountNumberResult = .failure(.invalidAccount)
        localDataSource.saveResult = .success(stub)
        remoteDataSource.getByAccountNumberResult = .success(stub)
        
        let account = sut.getByAccountNumber("accountNumber", date: date)
        let result = scheduler.createTestableSubscriber(VatTaxpayer.self, VatError.self)
        account.receive(subscriber: result)
        
        scheduler.resume()
        XCTAssertEqual(result.recordedOutput, [
            (0, .subscription),
            (0, .input(stub)),
            (0, .completion(.finished))
        ])
    }
    
    func testGetByAccountNumberAvailableLocalUnavailableRemote() {
        localDataSource.getByAccountNumberResult = .success(stub)
        
        let account = sut.getByAccountNumber("accountNumber", date: date)
        let result = scheduler.createTestableSubscriber(VatTaxpayer.self, VatError.self)
        account.receive(subscriber: result)
        
        scheduler.resume()
        XCTAssertEqual(result.recordedOutput, [
            (0, .subscription),
            (0, .input(stub)),
            (0, .completion(.finished))
        ])
    }
    
    func testGetByAccountNumberAvailableLocalAvailableRemote() {
        localDataSource.getByAccountNumberResult = .success(stub)
        remoteDataSource.getByAccountNumberResult = .success(stub)
        
        let account = sut.getByAccountNumber("accountNumber", date: date)
        let result = scheduler.createTestableSubscriber(VatTaxpayer.self, VatError.self)
        account.receive(subscriber: result)
        
        scheduler.resume()
        XCTAssertEqual(result.recordedOutput, [
            (0, .subscription),
            (0, .input(stub)),
            (0, .completion(.finished))
        ])
    }
    
    func testGetByAccountNumberUnavailableLocalAvailableRemoteSaveFail() {
        localDataSource.getByAccountNumberResult = .failure(.invalidAccount)
        localDataSource.saveResult = .failure(.unknown)
        remoteDataSource.getByAccountNumberResult = .success(stub)
        
        let account = sut.getByAccountNumber("accountNumber", date: date)
        let result = scheduler.createTestableSubscriber(VatTaxpayer.self, VatError.self)
        account.receive(subscriber: result)
        
        scheduler.resume()
        XCTAssertEqual(result.recordedOutput, [
            (0, .subscription),
            (0, .completion(.failure(.unknown)))
        ])
    }
    
    func testGetByRegonUnavailableLocalUnavailableRemote() {
        localDataSource.getByRegonResult = .failure(.invalidRegon)
        remoteDataSource.getByRegonResult = .failure(.invalidRegon)
        
        let regon = sut.getByRegon("regon", date: date)
        let result = scheduler.createTestableSubscriber(VatTaxpayer.self, VatError.self)
        regon.receive(subscriber: result)
        
        scheduler.resume()
        XCTAssertEqual(result.recordedOutput, [
            (0, .subscription),
            (0, .completion(.failure(.invalidRegon)))
        ])
    }
    
    func testGetByRegonUnavailableLocalAvailableRemote() {
        localDataSource.getByRegonResult = .failure(.invalidRegon)
        localDataSource.saveResult = .success(stub)
        remoteDataSource.getByRegonResult = .success(stub)
        
        let regon = sut.getByRegon("regon", date: date)
        let result = scheduler.createTestableSubscriber(VatTaxpayer.self, VatError.self)
        regon.receive(subscriber: result)
        
        scheduler.resume()
        XCTAssertEqual(result.recordedOutput, [
            (0, .subscription),
            (0, .input(stub)),
            (0, .completion(.finished))
        ])
    }
    
    func testGetByRegonAvailableLocalUnavailableRemote() {
        localDataSource.getByRegonResult = .success(stub)
        
        let regon = sut.getByRegon("regon", date: date)
        let result = scheduler.createTestableSubscriber(VatTaxpayer.self, VatError.self)
        regon.receive(subscriber: result)
        
        scheduler.resume()
        XCTAssertEqual(result.recordedOutput, [
            (0, .subscription),
            (0, .input(stub)),
            (0, .completion(.finished))
        ])
    }
    
    func testGetByRegonAvailableLocalAvailableRemote() {
        localDataSource.getByRegonResult = .success(stub)
        remoteDataSource.getByRegonResult = .success(stub)
        
        let regon = sut.getByRegon("regon", date: date)
        let result = scheduler.createTestableSubscriber(VatTaxpayer.self, VatError.self)
        regon.receive(subscriber: result)
        
        scheduler.resume()
        XCTAssertEqual(result.recordedOutput, [
            (0, .subscription),
            (0, .input(stub)),
            (0, .completion(.finished))
        ])
    }
    
    func testGetByRegonUnavailableLocalAvailableRemoteSaveFail() {
        localDataSource.getByRegonResult = .failure(.invalidRegon)
        localDataSource.saveResult = .failure(.unknown)
        remoteDataSource.getByRegonResult = .success(stub)
        
        let regon = sut.getByRegon("regon", date: date)
        let result = scheduler.createTestableSubscriber(VatTaxpayer.self, VatError.self)
        regon.receive(subscriber: result)
        
        scheduler.resume()
        XCTAssertEqual(result.recordedOutput, [
            (0, .subscription),
            (0, .completion(.failure(.unknown)))
        ])
    }
}
 

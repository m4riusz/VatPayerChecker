//
//  SearchTabMiddlewareTests.swift
//  MobileAppTests
//
//  Created by Mariusz Sut on 27/12/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import XCTest
import Core
import TestKit
import EntwineTest

@testable import MobileApp

final class SearchTabMiddlewareTests: BaseTestCase {
    private lazy var initialState = AppState(mainState: .init(tab: .vatTaxpayer),
                                             searchTabState: .init(searchQuery: "",
                                                                   searchDate: .from(year: 1990, month: 1, day: 1),
                                                                   showDatePicker: false,
                                                                   searchOption: .nip,
                                                                   status: .ready),
                                             aboutTabState: .init(status: .ready))
    private lazy var objectResult = ObjectResult<VatTaxpayer>(subject: .stub(name: "Name"),
                                                              requestDateTime: "requestDateTime",
                                                              requestId: "requestId")
    private lazy var repository = StubVatPayerCheckerRepository()
    private lazy var sut = SearchTabMiddleware(repository: repository, debugLogger: MockLogger()).middleware()
    private lazy var store = AppStore(initialState: initialState,
                                      reducer: AppReducer.reduce,
                                      middlewares: [sut])
    private lazy var scheduler = TestScheduler()
    
    func testSearchByNipSuccess() {
        repository.resultGetByNip = .success(objectResult)
        let middlewarePublisher = sut(initialState, SearchTabAction.searchByNip("", date: .now))
        let subscriber = scheduler.createTestableSubscriber(Action.self, Never.self)
        
        middlewarePublisher?.receive(subscriber: subscriber)
        scheduler.resume()

        let recorderEvents = subscriber.recordedOutput.mapInput { $0 as? SearchTabAction }

        XCTAssertEqual(recorderEvents, [
            (0, .subscription),
            (0, .input(.setResult(.success(objectResult)))),
            (0, .completion(.finished))
        ])
    }
    
    func testSearchByNipFailure() {
        repository.resultGetByNip = .failure(.invalidNip)
        let middlewarePublisher = sut(initialState, SearchTabAction.searchByNip("", date: .now))
        let subscriber = scheduler.createTestableSubscriber(Action.self, Never.self)
        
        middlewarePublisher?.receive(subscriber: subscriber)
        scheduler.resume()

        let recorderEvents = subscriber.recordedOutput.mapInput { $0 as? SearchTabAction }

        XCTAssertEqual(recorderEvents, [
            (0, .subscription),
            (0, .input(.setResult(.failure(.invalidNip)))),
            (0, .completion(.finished))
        ])
    }
    
    func testSearchByRegonSuccess() {
        repository.resultGetByRegon = .success(objectResult)
        let middlewarePublisher = sut(initialState, SearchTabAction.searchByRegon("", date: .now))
        let subscriber = scheduler.createTestableSubscriber(Action.self, Never.self)
        
        middlewarePublisher?.receive(subscriber: subscriber)
        scheduler.resume()

        let recorderEvents = subscriber.recordedOutput.mapInput { $0 as? SearchTabAction }

        XCTAssertEqual(recorderEvents, [
            (0, .subscription),
            (0, .input(.setResult(.success(objectResult)))),
            (0, .completion(.finished))
        ])
    }
    
    func testSearchByRegonFailure() {
        repository.resultGetByRegon = .failure(.invalidRegon)
        let middlewarePublisher = sut(initialState, SearchTabAction.searchByRegon("", date: .now))
        let subscriber = scheduler.createTestableSubscriber(Action.self, Never.self)
        
        middlewarePublisher?.receive(subscriber: subscriber)
        scheduler.resume()

        let recorderEvents = subscriber.recordedOutput.mapInput { $0 as? SearchTabAction }

        XCTAssertEqual(recorderEvents, [
            (0, .subscription),
            (0, .input(.setResult(.failure(.invalidRegon)))),
            (0, .completion(.finished))
        ])
    }

    func testSearchByAccountSuccess() {
        repository.resultGetByAccount = .success(objectResult)
        let middlewarePublisher = sut(initialState, SearchTabAction.searchByAccount("", date: .now))
        let subscriber = scheduler.createTestableSubscriber(Action.self, Never.self)
        
        middlewarePublisher?.receive(subscriber: subscriber)
        scheduler.resume()

        let recorderEvents = subscriber.recordedOutput.mapInput { $0 as? SearchTabAction }

        XCTAssertEqual(recorderEvents, [
            (0, .subscription),
            (0, .input(.setResult(.success(objectResult)))),
            (0, .completion(.finished))
        ])
    }
    
    func testSearchByAccountFailure() {
        repository.resultGetByAccount = .failure(.invalidAccount)
        let middlewarePublisher = sut(initialState, SearchTabAction.searchByAccount("", date: .now))
        let subscriber = scheduler.createTestableSubscriber(Action.self, Never.self)
        
        middlewarePublisher?.receive(subscriber: subscriber)
        scheduler.resume()

        let recorderEvents = subscriber.recordedOutput.mapInput { $0 as? SearchTabAction }

        XCTAssertEqual(recorderEvents, [
            (0, .subscription),
            (0, .input(.setResult(.failure(.invalidAccount)))),
            (0, .completion(.finished))
        ])
    }

    func testClearSearch() {
        let middlewarePublisher = sut(initialState, SearchTabAction.clearSearch)
        let subscriber = scheduler.createTestableSubscriber(Action.self, Never.self)
        
        middlewarePublisher?.receive(subscriber: subscriber)
        scheduler.resume()

        let recorderEvents = subscriber.recordedOutput.mapInput { $0 as? SearchTabAction }

        XCTAssertEqual(recorderEvents, [
            (0, .subscription),
            (0, .completion(.finished))
        ])
    }
    
    func testSetResultSuccess() {
        let middlewarePublisher = sut(initialState, SearchTabAction.setResult(.success(objectResult)))
        let subscriber = scheduler.createTestableSubscriber(Action.self, Never.self)
        
        middlewarePublisher?.receive(subscriber: subscriber)
        scheduler.resume()

        let recorderEvents = subscriber.recordedOutput.mapInput { $0 as? SearchTabAction }

        XCTAssertEqual(recorderEvents, [
            (0, .subscription),
            (0, .completion(.finished))
        ])
    }
    
    func testSetResultFailure() {
        let middlewarePublisher = sut(initialState, SearchTabAction.setResult(.failure(.invalidAccount)))
        let subscriber = scheduler.createTestableSubscriber(Action.self, Never.self)
        
        middlewarePublisher?.receive(subscriber: subscriber)
        scheduler.resume()

        let recorderEvents = subscriber.recordedOutput.mapInput { $0 as? SearchTabAction }

        XCTAssertEqual(recorderEvents, [
            (0, .subscription),
            (0, .completion(.finished))
        ])
    }
    
    func testSetSearchQuery() {
        let middlewarePublisher = sut(initialState, SearchTabAction.setSearchQuery("query"))
        let subscriber = scheduler.createTestableSubscriber(Action.self, Never.self)
        
        middlewarePublisher?.receive(subscriber: subscriber)
        scheduler.resume()

        let recorderEvents = subscriber.recordedOutput.mapInput { $0 as? SearchTabAction }

        XCTAssertEqual(recorderEvents, [
            (0, .subscription),
            (0, .completion(.finished))
        ])
    }
    
    func testSetSearchOption() {
        let middlewarePublisher = sut(initialState, SearchTabAction.setSearchOption(.regon))
        let subscriber = scheduler.createTestableSubscriber(Action.self, Never.self)
        
        middlewarePublisher?.receive(subscriber: subscriber)
        scheduler.resume()

        let recorderEvents = subscriber.recordedOutput.mapInput { $0 as? SearchTabAction }

        XCTAssertEqual(recorderEvents, [
            (0, .subscription),
            (0, .completion(.finished))
        ])
    }
    
    func testSetSearchDate() {
        let middlewarePublisher = sut(initialState, SearchTabAction.setSearchDate(.now))
        let subscriber = scheduler.createTestableSubscriber(Action.self, Never.self)
        
        middlewarePublisher?.receive(subscriber: subscriber)
        scheduler.resume()

        let recorderEvents = subscriber.recordedOutput.mapInput { $0 as? SearchTabAction }

        XCTAssertEqual(recorderEvents, [
            (0, .subscription),
            (0, .completion(.finished))
        ])
    }
    
    func testShowDatePicker() {
        let middlewarePublisher = sut(initialState, SearchTabAction.showDatePicker)
        let subscriber = scheduler.createTestableSubscriber(Action.self, Never.self)
        
        middlewarePublisher?.receive(subscriber: subscriber)
        scheduler.resume()

        let recorderEvents = subscriber.recordedOutput.mapInput { $0 as? SearchTabAction }

        XCTAssertEqual(recorderEvents, [
            (0, .subscription),
            (0, .completion(.finished))
        ])
    }
    
    func testHideDatePicker() {
        let middlewarePublisher = sut(initialState, SearchTabAction.hideDatePicker)
        let subscriber = scheduler.createTestableSubscriber(Action.self, Never.self)
        
        middlewarePublisher?.receive(subscriber: subscriber)
        scheduler.resume()

        let recorderEvents = subscriber.recordedOutput.mapInput { $0 as? SearchTabAction }

        XCTAssertEqual(recorderEvents, [
            (0, .subscription),
            (0, .completion(.finished))
        ])
    }
}

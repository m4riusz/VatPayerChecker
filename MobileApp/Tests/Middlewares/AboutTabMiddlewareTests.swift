//
//  AboutTabMiddlewareTests.swift
//  MobileApp
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

final class AboutTabMiddlewareTests: BaseTestCase {
    private lazy var initialState = AppState(mainState: .init(tab: .vatTaxpayer),
                                             searchTabState: .init(searchQuery: "",
                                                                   searchDate: .from(year: 1990, month: 1, day: 1),
                                                                   showDatePicker: false,
                                                                   searchOption: .nip,
                                                                   status: .ready),
                                             aboutTabState: .init(status: .ready))
    private lazy var about = About(apiUrl: "ApiUrl",
                                   usedLibraries: [.init(name: "Lib", url: "LibUrl", license: "LibLicense")])
    private lazy var sut = AboutTabMiddleware(repository: StubAboutRepository(resultGetAbout: .success(about))).middleware()
    private lazy var store = AppStore(initialState: initialState,
                                      reducer: AppReducer.reduce,
                                      middlewares: [sut])
    private lazy var scheduler = TestScheduler()
    
    func testLoad() {
        let middlewarePublisher = sut(initialState, AboutAction.load)
        
        let subscriber = scheduler.createTestableSubscriber(Action.self, Never.self)
        
        middlewarePublisher?.receive(subscriber: subscriber)
        scheduler.resume()

        let recorderEvents = subscriber.recordedOutput.mapInput { $0 as? AboutAction }

        XCTAssertEqual(recorderEvents, [
            (0, .subscription),
            (0, .input(.setResult(about))),
            (0, .completion(.finished))
        ])
    }
    
    func testSetResult() {
        let middlewarePublisher = sut(initialState, AboutAction.setResult(about))
        
        let subscriber = scheduler.createTestableSubscriber(Action.self, Never.self)
        
        middlewarePublisher?.receive(subscriber: subscriber)
        scheduler.resume()

        let recorderEvents = subscriber.recordedOutput.mapInput { $0 as? AboutAction }

        XCTAssertEqual(recorderEvents, [
            (0, .subscription),
            (0, .completion(.finished))
        ])
    }
}

//
//  SearchTabMiddleware.swift
//  MobileApp
//
//  Created by Mariusz Sut on 14/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import Core
import Combine

struct SearchTabMiddleware {
    private let repository: VatPayerCheckerRepositoryProtocol
    private let analytics: AnalyticsProtocol
    private let debugLogger: DebugLogger
    
    init(repository: VatPayerCheckerRepositoryProtocol, analytics: AnalyticsProtocol, debugLogger: DebugLogger) {
        self.repository = repository
        self.analytics = analytics
        self.debugLogger = debugLogger
    }
    
    func middleware() -> Middleware<AppState, Action> {
        return { _, action in
            guard let action = action as? SearchTabAction else {
                return Empty().eraseToAnyPublisher()
            }
            switch action {
            case .searchByNip(let nip, let date):
                debugLogger.verbose("Search by nip: \(nip), date: \(date.yyyyMMdd)")
                analytics.log(event: .searchByNip)
                return repository.getByNip(nip, date: date)
                    .map { SearchTabAction.setResult(.success($0))}
                    .catch({ Just(SearchTabAction.setResult(.failure($0))) })
                    .eraseToAnyPublisher()
            case .searchByRegon(let regon, let date):
                debugLogger.verbose("Search by regon: \(regon), date: \(date.yyyyMMdd)")
                analytics.log(event: .searchByRegon)
                return repository.getByRegon(regon, date: date)
                    .map { SearchTabAction.setResult(.success($0))}
                    .catch({ Just(SearchTabAction.setResult(.failure($0))) })
                    .eraseToAnyPublisher()
            case .searchByAccount(let account, let date):
                debugLogger.verbose("Search by account: \(account), date: \(date.yyyyMMdd)")
                analytics.log(event: .searchByAccount)
                return repository.getByAccountNumber(account, date: date)
                    .map { SearchTabAction.setResult(.success($0))}
                    .catch({ Just(SearchTabAction.setResult(.failure($0))) })
                    .eraseToAnyPublisher()
            case .setResult(let result):
                switch result {
                case .success:
                    analytics.log(event: .successSearch)
                case .failure(let error):
                    analytics.log(event: .error(.search, error.rawValue))
                }
            case .clearSearch, .setSearchQuery, .setSearchOption,
                 .setSearchDate, .showDatePicker, .hideDatePicker:
                break
            }
            return Empty().eraseToAnyPublisher()
        }
    }
}

//
//  VatTaxpayerMiddleware.swift
//  VatPayerChecker
//
//  Created by Mariusz Sut on 14/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import Core
import Combine

struct VatTaxpayerMiddleware {
    private let repository: VatPayerCheckerRepositoryProtocol
    
    init(repository: VatPayerCheckerRepositoryProtocol) {
        self.repository = repository
    }
    
    func middleware() -> Middleware<AppState, Action> {
        return { state, action in
            guard let action = action as? VatTaxpayerAction else {
                return Empty().eraseToAnyPublisher()
            }
            switch action {
            case .searchByNip(let nip, let date):
                return repository.getByNip(nip, date: date)
                    .map { VatTaxpayerAction.setResult(.success($0))}
                    .catch({ Just(VatTaxpayerAction.setResult(.failure($0))) })
                    .eraseToAnyPublisher()
            case .searchByRegon(let regon, let date):
                return repository.getByRegon(regon, date: date)
                    .map { VatTaxpayerAction.setResult(.success($0))}
                    .catch({ Just(VatTaxpayerAction.setResult(.failure($0))) })
                    .eraseToAnyPublisher()
            case .searchByAccount(let account, let date):
                return repository.getByAccountNumber(account, date: date)
                    .map { VatTaxpayerAction.setResult(.success($0))}
                    .catch({ Just(VatTaxpayerAction.setResult(.failure($0))) })
                    .eraseToAnyPublisher()
            case .clearSearch, .setResult, .setSearchQuery, .setSearchOption, .setSearchDate:
                break
            }
            return Empty().eraseToAnyPublisher()
        }
    }
}

//
//  VatPayerCheckerRepository.swift
//  Core
//
//  Created by Mariusz Sut on 11/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import Combine

public protocol VatPayerCheckerRepositoryProtocol {
    func getByNip(_ nip: String, date: Date) -> AnyPublisher<VatTaxpayer, VatError>
    func getByAccountNumber(_ accountNumber: String, date: Date) -> AnyPublisher<VatTaxpayer, VatError>
    func getByRegon(_ regon: String, date: Date) -> AnyPublisher<VatTaxpayer, VatError>
}

public final class VatPayerCheckerRepository: VatPayerCheckerRepositoryProtocol {
    private let local: VatPayerCheckerDataSourceProtocol
    private let remote: VatPayerCheckerDataSourceProtocol
    
    public init(local: VatPayerCheckerDataSourceProtocol, remote: VatPayerCheckerDataSourceProtocol) {
        self.local = local
        self.remote = remote
    }
    
    public func getByNip(_ nip: String, date: Date) -> AnyPublisher<VatTaxpayer, VatError> {
        local.getByNip(nip, date: date)
            .catch { [unowned self] _ in self.remote.getByNip(nip, date: date) }
            .flatMap { [unowned self] in self.local.save(nip, date: date, result: $0) }
            .eraseToAnyPublisher()
    }
    
    public func getByAccountNumber(_ accountNumber: String, date: Date) -> AnyPublisher<VatTaxpayer, VatError> {
        local.getByAccountNumber(accountNumber, date: date)
            .catch { [unowned self] _ in self.remote.getByAccountNumber(accountNumber, date: date) }
            .flatMap { [unowned self] in self.local.save(accountNumber, date: date, result: $0) }
            .eraseToAnyPublisher()
    }
    
    public func getByRegon(_ regon: String, date: Date) -> AnyPublisher<VatTaxpayer, VatError> {
        local.getByRegon(regon, date: date)
            .catch { [unowned self] _ in self.remote.getByRegon(regon, date: date) }
            .flatMap { [unowned self] in self.local.save(regon, date: date, result: $0) }
            .eraseToAnyPublisher()
    }
}

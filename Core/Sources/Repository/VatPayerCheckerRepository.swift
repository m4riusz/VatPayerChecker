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
    func getByNip(_ nip: String, date: Date) -> AnyPublisher<ObjectResult<VatTaxpayer>, VatError>
    func getByAccountNumber(_ accountNumber: String, date: Date) -> AnyPublisher<ObjectResult<VatTaxpayer>, VatError>
    func getByRegon(_ regon: String, date: Date) -> AnyPublisher<ObjectResult<VatTaxpayer>, VatError>
}

public final class VatPayerCheckerRepository: VatPayerCheckerRepositoryProtocol {
    private let local: VatPayerCheckerDataSourceProtocol
    private let remote: VatPayerCheckerDataSourceProtocol
    
    public init(local: VatPayerCheckerDataSourceProtocol, remote: VatPayerCheckerDataSourceProtocol) {
        self.local = local
        self.remote = remote
    }
    
    public func getByNip(_ nip: String, date: Date) -> AnyPublisher<ObjectResult<VatTaxpayer>, VatError> {
        local.getByNip(nip, date: date)
            .catch { [weak self] _ -> AnyPublisher<ObjectResult<VatTaxpayer>, VatError> in
                guard let strongSelf = self else {
                    return Fail<ObjectResult<VatTaxpayer>, VatError>(error: .unknown)
                        .eraseToAnyPublisher()
                }
                return strongSelf.remote.getByNip(nip, date: date)
                    .flatMap { result in strongSelf.local.save(nip, date: date, result: result) }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    public func getByAccountNumber(_ accountNumber: String, date: Date) -> AnyPublisher<ObjectResult<VatTaxpayer>, VatError> {
        local.getByAccountNumber(accountNumber, date: date)
            .catch { [weak self] _ -> AnyPublisher<ObjectResult<VatTaxpayer>, VatError> in
                guard let strongSelf = self else {
                    return Fail<ObjectResult<VatTaxpayer>, VatError>(error: .unknown)
                        .eraseToAnyPublisher()
                }
                return strongSelf.remote.getByAccountNumber(accountNumber, date: date)
                    .flatMap { result in strongSelf.local.save(accountNumber, date: date, result: result) }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    public func getByRegon(_ regon: String, date: Date) -> AnyPublisher<ObjectResult<VatTaxpayer>, VatError> {
        local.getByRegon(regon, date: date)
            .catch { [weak self] _ -> AnyPublisher<ObjectResult<VatTaxpayer>, VatError> in
                guard let strongSelf = self else {
                    return Fail<ObjectResult<VatTaxpayer>, VatError>(error: .unknown)
                        .eraseToAnyPublisher()
                }
                return strongSelf.remote.getByRegon(regon, date: date)
                    .flatMap { result in strongSelf.local.save(regon, date: date, result: result) }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

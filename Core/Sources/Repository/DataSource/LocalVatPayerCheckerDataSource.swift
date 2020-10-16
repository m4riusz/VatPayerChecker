//
//  LocalVatPayerCheckerDataSource.swift
//  Core
//
//  Created by Mariusz Sut on 10/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import Combine

public final class LocalVatPayerCheckerDataSource: VatPayerCheckerDataSourceProtocol {
    private var map: [String: VatTaxpayer] = [:]
    
    public init() { /* Nop */ }
    
    public func save(_ search: String, date: Date, result: VatTaxpayer) -> Future<VatTaxpayer, VatError> {
        Future { [weak self] promise in
            guard let strongSelf = self else {
                promise(.failure(.unknown))
                return
            }
            strongSelf.map[strongSelf.keyFrom(query: search, date: date)] = result
            promise(.success(result))
        }
    }
    
    public func getByNip(_ nip: String, date: Date) -> Future<VatTaxpayer, VatError> {
        Future { [weak self] promise in
            guard let strongSelf = self,
                  let item = strongSelf.map[strongSelf.keyFrom(query: nip, date: date)] else {
                promise(.failure(.invalidNip))
                return
            }
            promise(.success(item))
        }
    }
    
    public func getByAccountNumber(_ accountNumber: String, date: Date) -> Future<VatTaxpayer, VatError> {
        Future { [weak self] promise in
            guard let strongSelf = self,
                  let item = strongSelf.map[strongSelf.keyFrom(query: accountNumber, date: date)] else {
                promise(.failure(.invalidAccount))
                return
            }
            promise(.success(item))
        }
    }
    
    public func getByRegon(_ regon: String, date: Date) -> Future<VatTaxpayer, VatError> {
        Future { [weak self] promise in
            guard let strongSelf = self,
                  let item = strongSelf.map[strongSelf.keyFrom(query: regon, date: date)] else {
                promise(.failure(.invalidRegon))
                return
            }
            promise(.success(item))
        }
    }
    
    private func keyFrom(query: String, date: Date) -> String {
        "\(query).(\(date.yyyyMMdd))"
    }
}

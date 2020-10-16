//
//  StubVatPayerCheckerDataSource.swift
//  CoreTests
//
//  Created by Mariusz Sut on 16/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import Combine
import Core

final class StubVatPayerCheckerDataSource: VatPayerCheckerDataSourceProtocol {
    var saveResult: Result<VatTaxpayer, VatError>!
    var getByNipResult: Result<VatTaxpayer, VatError>!
    var getByAccountNumberResult: Result<VatTaxpayer, VatError>!
    var getByRegonResult: Result<VatTaxpayer, VatError>!
    
    func save(_ search: String, date: Date, result: VatTaxpayer) -> Future<VatTaxpayer, VatError> {
        Future { [unowned self] promise in
            promise(saveResult!)
        }
    }
    
    func getByNip(_ nip: String, date: Date) -> Future<VatTaxpayer, VatError> {
        Future { [unowned self] promise in
            promise(getByNipResult!)
        }
    }
    
    func getByAccountNumber(_ accountNumber: String, date: Date) -> Future<VatTaxpayer, VatError> {
        Future { [unowned self] promise in
            promise(getByAccountNumberResult!)
        }
    }
    
    func getByRegon(_ regon: String, date: Date) -> Future<VatTaxpayer, VatError> {
        Future { [unowned self] promise in
            promise(getByRegonResult!)
        }
    }
}

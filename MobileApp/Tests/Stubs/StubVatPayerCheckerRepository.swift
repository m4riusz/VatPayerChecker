//
//  StubVatPayerCheckerRepository.swift
//  MobileAppTests
//
//  Created by Mariusz Sut on 27/12/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import Combine
import Core

@testable import MobileApp

struct StubVatPayerCheckerRepository: VatPayerCheckerRepositoryProtocol {
    var resultGetByNip: Result<ObjectResult<VatTaxpayer>, VatError>!
    var resultGetByRegon: Result<ObjectResult<VatTaxpayer>, VatError>!
    var resultGetByAccount: Result<ObjectResult<VatTaxpayer>, VatError>!
    
    func getByNip(_ nip: String, date: Date) -> AnyPublisher<ObjectResult<VatTaxpayer>, VatError> {
        Future { $0(resultGetByNip) }
            .eraseToAnyPublisher()
    }
    
    func getByAccountNumber(_ accountNumber: String, date: Date) -> AnyPublisher<ObjectResult<VatTaxpayer>, VatError> {
        Future { $0(resultGetByAccount) }
            .eraseToAnyPublisher()
    }
    
    func getByRegon(_ regon: String, date: Date) -> AnyPublisher<ObjectResult<VatTaxpayer>, VatError> {
        Future { $0(resultGetByRegon) }
            .eraseToAnyPublisher()
    }
}

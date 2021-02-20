//
//  VatPayerCheckerDataSourceProtocol.swift
//  Core
//
//  Created by Mariusz Sut on 06/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import Combine

public protocol VatPayerCheckerDataSourceProtocol {
    func save(_ search: String, date: Date, result: ObjectResult<VatTaxpayer>) -> Future<ObjectResult<VatTaxpayer>, VatError>
    func getByNip(_ nip: String, date: Date) -> Future<ObjectResult<VatTaxpayer>, VatError>
    func getByAccountNumber(_ accountNumber: String, date: Date) -> Future<ObjectResult<VatTaxpayer>, VatError>
    func getByRegon(_ regon: String, date: Date) -> Future<ObjectResult<VatTaxpayer>, VatError>
}

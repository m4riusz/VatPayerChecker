//
//  VatPayerDataSource.swift
//  Core
//
//  Created by Mariusz Sut on 06/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import Combine
import Moya

protocol VatPayerDataSource {
    func getByNip(_ nip: String, date: Date) -> Future<VatTaxpayer, VatError>
    func getByAccountNumber(_ accountNumber: String, date: Date) -> Future<VatTaxpayer, VatError>
    func getByRegon(_ regon: String, date: Date) -> Future<VatTaxpayer, VatError>
}

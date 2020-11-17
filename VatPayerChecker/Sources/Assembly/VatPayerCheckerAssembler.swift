//
//  VatPayerCheckerAssembler.swift
//  VatPayerChecker
//
//  Created by Mariusz Sut on 25/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import Swinject

final class VatPayerCheckerAssembler: Assembler {
    private lazy var container = Container()
    
    let assemblies: [Assembly] = [
        CoreAssembly(),
        VatTaxpayerAssembly()
    ]
    
    func assembly() -> Container {
        assemblies.forEach { $0.register(container: container) }
        return container
    }
}

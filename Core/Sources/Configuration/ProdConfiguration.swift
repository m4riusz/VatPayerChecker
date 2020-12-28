//
//  ProdConfiguration.swift
//  Core
//
//  Created by Mariusz Sut on 11/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation

public struct ProdConfiguration: ConfigurationProtocol {
    public let apiAddress = URL(string: "https://wl-api.mf.gov.pl")!
    public let certificate = "wl-test.mf.gov.pl.cer"
    
    public init() { /* Nop */ }
}

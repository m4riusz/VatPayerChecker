//
//  AboutRepository.swift
//  Core
//
//  Created by Mariusz Sut on 25/12/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import Combine

public protocol AboutRepositoryProtocol {
    func getAbout() -> AnyPublisher<About, Never>
}

public final class AboutRepository: AboutRepositoryProtocol {
    private let local: AboutDataSourceProtocol
    
    public init(local: AboutDataSourceProtocol) {
        self.local = local
    }
    
    public func getAbout() -> AnyPublisher<About, Never> {
        local.getAbout().eraseToAnyPublisher()
    }
}

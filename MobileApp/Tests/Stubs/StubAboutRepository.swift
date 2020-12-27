//
//  StubAboutRepository.swift
//  MobileApp
//
//  Created by Mariusz Sut on 27/12/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import Combine
import Core

@testable import MobileApp

struct StubAboutRepository: AboutRepositoryProtocol {
    var resultGetAbout: Result<About, Never>
    
    func getAbout() -> AnyPublisher<About, Never> {
        Future { $0(resultGetAbout) }
            .eraseToAnyPublisher()
    }
}

//
//  ObjectResult.swift
//  Core
//
//  Created by Mariusz Sut on 11/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation

public struct ObjectResult<T: Codable & Equatable> {
    public let subject: T
    public let requestDateTime: String
    public let requestId: String
    
    public init(subject: T, requestDateTime: String, requestId: String) {
        self.subject = subject
        self.requestDateTime = requestDateTime
        self.requestId = requestId
    }
}

extension ObjectResult: Equatable { /*Nop*/ }

extension ObjectResult: Codable {
    
    enum CodingKeys: String, CodingKey {
        case subject
        case requestDateTime
        case requestId
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        subject = try container.decode(T.self, forKey: .subject)
        requestDateTime = try container.decode(String.self, forKey: .requestDateTime)
        requestId = try container.decode(String.self, forKey: .requestId)
    }
}

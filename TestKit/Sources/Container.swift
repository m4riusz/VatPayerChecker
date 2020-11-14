//
//  Container.swift
//  TestKit
//
//  Created by Mariusz Sut on 14/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import SwiftUI

public struct Container<T: View>: View {
    let view: T
    let width: CGFloat?
    let height: CGFloat?
    
    public init(view: T, width: CGFloat? = 100, height: CGFloat? = 100) {
        self.view = view
        self.width = width
        self.height = height
    }
    
    public var body: some View {
        view
            .frame(width: width, height: height)
    }
}

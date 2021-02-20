//
//  ListContainer.swift
//  TestKit
//
//  Created by Mariusz Sut on 21/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import SwiftUI

public struct ListContainer<T: View>: View {
    let view: T
    let width: CGFloat?
    
    public init(view: T, width: CGFloat? = 200) {
        self.view = view
        self.width = width
    }
    
    public var body: some View {
        List {
            view
        }
        .frame(maxWidth: width)
    }
}

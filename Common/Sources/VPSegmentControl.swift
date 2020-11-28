//
//  VPSegmentControl.swift
//  Common
//
//  Created by Mariusz Sut on 28/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI

public protocol VPSegmentControlItem: Hashable {
    var text: String { get }
}

public struct VPSegmentControl<T: VPSegmentControlItem>: View {
    private let items: [T]
    private let selection: Binding<T>
    private let spacing: CGFloat?
    
    public init(items: [T], selection: Binding<T>, spacing: CGFloat? = 5) {
        self.items = items
        self.selection = selection
        self.spacing = spacing
    }
    
    public var body: some View {
        HStack(spacing: spacing) {
            ForEach(items, id: \.self) {
                stackViewButton(text: $0.text, option: $0)
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private func stackViewButton(text: String, option: T) -> some View {
        Button(action: {
            if selection.wrappedValue != option {
                selection.wrappedValue = option
            }
        }, label: {
            Spacer()
            Text(text)
                .fontWeight(.semibold)
                .font(.title3)
                .frame(maxHeight: .infinity)
            Spacer()
        })
        .border(Color.accentColor)
        .foregroundColor(selection.wrappedValue == option ? .white : .accentColor)
        .background(selection.wrappedValue == option ? Color.accentColor : Color.white)
    }
}

struct VPSegmentControl_Previews: PreviewProvider {
    enum Sample: VPSegmentControlItem {
        case text
        
        var text: String {
            "text"
        }
    }
    
    private static var selection: Binding<Sample> {
        Binding<Sample>(get: { .text }, set: { _ in })
    }
    
    static var previews: some View {
        VPSegmentControl<Sample>(items: [.text], selection: selection)
    }
}

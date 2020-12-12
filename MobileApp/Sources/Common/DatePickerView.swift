//
//  DatePickerView.swift
//  MobileApp
//
//  Created by Mariusz Sut on 12/12/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI
import Combine
import Common
import Core

struct DatePickerView: View {
    let title: String
    let cancel: String
    let accept: String
    let minDate: Date
    let maxDate: Date
    let onDismiss: VoidHandler
    let onDatePicked: (Date) -> Void
    @State var currentDate: Date
    
    init(title: String,
         cancel: String,
         accept: String,
         currentDate: Date,
         minDate: Date,
         maxDate: Date,
         onDismiss: @escaping VoidHandler,
         onDatePicked: @escaping (Date) -> Void) {
        self.title = title
        self.cancel = cancel
        self.accept = accept
        self.minDate = minDate
        self.maxDate = maxDate
        self.onDismiss = onDismiss
        self.onDatePicked = onDatePicked
        self._currentDate = State(initialValue: currentDate)
    }
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    onDismiss()
                }
            VStack {
                Text(title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .font(.title2)
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                
                DatePicker("", selection: $currentDate, in: minDate...maxDate, displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
                    .fixedSize()
                VPButton(style: .action, text: accept) {
                    onDatePicked(currentDate)
                }
                .padding([.leading, .trailing], 10)
                VPButton(style: .link, text: cancel) {
                    onDismiss()
                }
                .padding([.leading, .trailing], 10)
                
            }
            .frame(width: 350, alignment: .center)
            .background(Color.white)
            .cornerRadius(10)
        }
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView(title: "title",
                       cancel: "cancel",
                       accept: "accept",
                       currentDate: Date(),
                       minDate: Date(),
                       maxDate: Date(),
                       onDismiss: { /*Nop*/ },
                       onDatePicked: { _ in /*Nop*/ })
    }
}

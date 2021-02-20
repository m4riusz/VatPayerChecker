//
//  VatTaxpayerPersonRow.swift
//  MobileApp
//
//  Created by Mariusz Sut on 20/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI
import Core

struct VatTaxpayerPersonRow: View {
    private typealias Literals = MobileAppStrings
    let title: String
    let persons: [Person]
    
    init(title: String, person: Person) {
        self.init(title: title, persons: [person])
    }
    
    init(title: String, persons: [Person]) {
        self.title = title
        self.persons = persons
    }
    
    var body: some View {
        Section(header:
                    HStack {
                        Text(title)
                            .font(.caption)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(8)
                    .background(Color.blue)
                    .listRowInsets(EdgeInsets()),
                content: {
                    ForEach(persons, id: \.self) {
                        personView(person: $0)
                    }
                })
    }
    
    private func personView(person: Person) -> some View {
        LazyVStack(alignment: .leading) {
            if !person.companyName.isEmpty {
                keyValueView(key: Literals.personCompanyName, value: person.companyName)
            }
            if !person.nip.isEmpty {
                keyValueView(key: Literals.personNIP, value: person.nip)
            }
            if !person.pesel.isEmpty {
                keyValueView(key: Literals.personPESEL, value: person.pesel)
            }
            if !person.firstName.isEmpty {
                keyValueView(key: Literals.personFirstName, value: person.firstName)
            }
            if !person.lastName.isEmpty {
                keyValueView(key: Literals.personLastName, value: person.lastName)
            }
        }
    }
    
    private func keyValueView(key: String, value: String) -> some View {
        LazyVStack(alignment: .leading) {
            Text(key)
                .font(.caption)
            Text(value)
                .font(.body)
                .bold()
        }
    }
}

struct VatTaxpayerPersonRow_Previews: PreviewProvider {
    static var previews: some View {
        VatTaxpayerPersonRow(title: "Representative",
                             person: Person(companyName: "Company name sp z.o o",
                                            firstName: "Janusz",
                                            lastName: "Pawlacz",
                                            pesel: "12398477263",
                                            nip: "3362947295"))
    }
}

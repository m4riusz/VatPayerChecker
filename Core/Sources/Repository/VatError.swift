//
//  VatError.swift
//  Core
//
//  Created by Mariusz Sut on 10/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation

/*
 KOD BŁĘDU  STATUS HTTP  KOMUNIKAT BŁĘDU
 WL-100     500          Wystąpił nieoczekiwany błąd serwera.
 WL-101     400          Pole 'data' nie może być puste.
 WL-102     400          Pole 'data' ma nieprawidłowy format.
 WL-103     400          Data nie może być datą przyszłą.
 WL-104     400          Pole 'REGON' nie może być puste.
 WL-105     400          Pole 'REGON' ma nieprawidłową długość. Wymagane 9 lub 14 znaków (nr).
 WL-106     400          Pole 'REGON' zawiera niedozwolone znaki. Wymagane tylko cyfry (nr).
 WL-107     400          Nieprawidłowy REGON (nr).
 WL-108     400          Pole 'numer konta' nie może być puste.
 WL-109     400          Pole 'numer konta' ma nieprawidłową długość. Wymagane 26 znaków (nr).
 WL-110     400          Pole 'numer konta' zawiera niedozwolone znaki. Wymagane tylko cyfry (nr).
 WL-111     400          Nieprawidłowy numer konta bankowego (nr).
 WL-112     400          Pole 'NIP' nie może być puste.
 WL-113     400          Pole 'NIP' ma nieprawidłową długość. Wymagane 10 znaków (nr).
 WL-114     400          Pole 'NIP' zawiera niedozwolone znaki. Wymagane tylko cyfry (nr).
 WL-115     400          Nieprawidłowy NIP (nr).
 WL-116     400          Pole 'nazwa podmiotu' nie może być puste.
 WL-117     400          Pole 'nazwa podmiotu' za krótkie. Wymagane przynajmniej 5 znaków.
 WL-118     400          Data sprzed zakresu rejestru.
 WL-130     400          Przekroczono maksymalna liczbę argumentów zapytania.
 WL-190     400          Niepoprawne żądanie.
 WL-191     429          Limit żądań dla tego adresu IP został na dziś wyczerpany.
 WL-195     400          Zaktualizowaliśmy bazę danych. Wykonaj ponownie zapytanie, aby otrzymać aktualne dane.
 WL-196     400          Trwa aktualizacja bazy danych. Spróbuj ponownie później.
 */

public enum VatError: String {
    case unknown
    case noInternetConnection
    case serverError = "WL-100"
    case emptyDate = "WL-101"
    case invalidDateFormat = "WL-102"
    case futureDate = "WL-103"
    case emptyRegon = "WL-104"
    case invalidRegonLength = "WL-105"
    case invalidRegonCharacters = "WL-106"
    case invalidRegon = "WL-107"
    case emptyAccount = "WL-108"
    case invalidAccountLength = "WL-109"
    case invalidAccountCharacters = "WL-110"
    case invalidAccount = "WL-111"
    case emptyNip = "WL-112"
    case invalidNipLength = "WL-113"
    case invalidNipCharacters = "WL-114"
    case invalidNip = "WL-115"
    case emptyCompanyName = "WL-116"
    case companyNameTooShort = "WL-117"
    case tooOldDate = "WL-118"
    case tooMuchApiParams = "WL-130"
    case invalidRequest = "WL-190"
    case apiLimitReached = "WL-191"
    case newData = "WL-195"
    case databaseUpdateInProgress = "WL-196"
    
}

extension VatError: Error {}

extension VatError: Codable {}

//
//  VatTaxpayerSearchTab.swift
//  MobileApp
//
//  Created by Mariusz Sut on 14/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI
import Combine
import Core

struct VatTaxpayerSearchTab: View {
    private typealias Literals = MobileAppStrings
    private struct Constants {
        static let searchButtonAnalytics = "search"
        static let datePickerButtonAnalytics = "datePicker"
    }
    @EnvironmentObject var store: AppStore
    private var state: SearchTabState {
        store.state.searchTabState
    }
    
    var body: some View {
        getByState(status: state.status)
    }
    
    private func getByState(status: SearchTabLoadable) -> some View {
        NavigationView {
            ZStack {
                if state.showDatePicker {
                    DatePickerView(title: Literals.selectDate,
                                   cancel: Literals.cancel,
                                   accept: Literals.pick,
                                   currentDate: state.searchDate,
                                   minDate: .from(year: 1900, month: 1, day: 1),
                                   maxDate: Date(),
                                   onDismiss: {
                                    store.dispatch(SearchTabAction.hideDatePicker)
                                   },
                                   onDatePicked: { date in
                                    store.dispatch(SearchTabAction.setSearchDate(date))
                                    store.dispatch(SearchTabAction.hideDatePicker)
                                   })
                        .uiKitOnAppear { store.dispatch(AnalyticsAction.event(.screenAppear(.datePicker))) }
                        .uiKitOnDisappear { store.dispatch(AnalyticsAction.event(.screenDisappear(.datePicker))) }
                        .zIndex(1)
                }
                if status == .loading {
                    getLoadingView()
                        .uiKitOnAppear { store.dispatch(AnalyticsAction.event(.showLoader(.search))) }
                        .uiKitOnDisappear { store.dispatch(AnalyticsAction.event(.hideLoader(.search))) }
                        .zIndex(1)
                }
                
                switch status {
                case .ready, .loading:
                    getReadyView()
                        .navigationBarHidden(true)
                case .success(let result):
                    getSuccessView(result: result)
                        .navigationBarTitle(result.subject.name, displayMode: .inline)
                        .navigationBarItems(leading: Button(Literals.back, action: {
                            store.dispatch(SearchTabAction.clearSearch)
                        }))
                        .navigationBarHidden(false)
                case .error(let error):
                    getErrorView(error: error)
                        .navigationBarHidden(true)
                }
            }
        }
    }
    
    private func getReadyView() -> some View {
        VatTaxpayerSearchBar(searchDate: searchDate,
                             searchText: searchText,
                             searchOption: searchOption,
                             error: nil,
                             onSearchTap: search,
                             onDateTap: dateSelection)
    }
    
    private func getLoadingView() -> some View {
        LoadingView(text: Literals.loading)
    }
    
    private func getSuccessView(result: ObjectResult<VatTaxpayer>) -> some View {
        VatTaxpayerView(vatTaxpayer: result.subject,
                        actionText: Literals.copy,
                        action: { text in
                            let generator = UIImpactFeedbackGenerator(style: .light)
                            generator.impactOccurred()
                            UIPasteboard.general.string = text
                        },
                        searchDate: result.requestDateTime,
                        searchId: result.requestId)
    }
    
    private func getErrorView(error: VatError) -> some View {
        VatTaxpayerSearchBar(searchDate: searchDate,
                             searchText: searchText,
                             searchOption: searchOption,
                             error: error.localizedMessage,
                             onSearchTap: search,
                             onDateTap: dateSelection)
    }
}

private extension VatError {
    private typealias Literals = MobileAppStrings
    
    var localizedMessage: String {
        switch self {
        case .invalidNip:
            return Literals.invalidNip
        case .invalidAccount:
            return Literals.invalidAccount
        case .noInternetConnection:
            return Literals.noInternetConnection
        case .serverError:
            return Literals.serverError
        case .emptyRegon:
            return Literals.emptyRegonError
        case .invalidRegonLength:
            return Literals.invalidRegonFormat
        case .invalidRegonCharacters:
            return Literals.invalidRegonCharacters
        case .invalidRegon:
            return Literals.invalidRegon
        case .emptyAccount:
            return Literals.emptyAccountNumber
        case .invalidAccountLength:
            return Literals.invalidAccountNumberFormat
        case .invalidAccountCharacters:
            return Literals.invalidAccountNumberCharacters
        case .emptyNip:
            return Literals.emptyNipError
        case .invalidNipLength:
            return Literals.invalidNipFormat
        case .invalidNipCharacters:
            return Literals.invalidNipCharacters
        case .tooOldDate:
            return Literals.dateTooOldError
        case .apiLimitReached:
            return Literals.apiLimitReachedError
        case .databaseUpdateInProgress:
            return Literals.databaseUpdateInProgressError
        case .unknown, .emptyDate, .invalidDateFormat, .emptyCompanyName,
             .companyNameTooShort, .futureDate, .invalidRequest, .newData, .tooMuchApiParams:
            return Literals.unknownError
        }
    }
}

// MARK: - Search bar
extension VatTaxpayerSearchTab {
    
    private var searchDate: Binding<Date> {
        Binding<Date>(get: {
            state.searchDate
        }, set: { date in
            store.dispatch(SearchTabAction.setSearchDate(date))
        })
    }
    
    private var searchText: Binding<String> {
        Binding<String>(get: {
            state.searchQuery
        }, set: { query in
            store.dispatch(SearchTabAction.setSearchQuery(query))
        })
    }
    
    private var searchOption: Binding<VatTaxpayerSearchBar.Option> {
        Binding<VatTaxpayerSearchBar.Option>(get: {
            state.searchOption
        }, set: { option in
            store.dispatch(SearchTabAction.setSearchOption(option))
            store.dispatch(AnalyticsAction.event(.buttonTap(.search, option.analytics)))
        })
    }
    
    private func search() {
        switch state.searchOption {
        case .nip:
            store.dispatch(SearchTabAction.searchByNip(state.searchQuery, date: state.searchDate))
        case .regon:
            store.dispatch(SearchTabAction.searchByRegon(state.searchQuery, date: state.searchDate))
        case .account:
            store.dispatch(SearchTabAction.searchByAccount(state.searchQuery, date: state.searchDate))
        }
        store.dispatch(AnalyticsAction.event(.buttonTap(.search, Constants.searchButtonAnalytics)))
    }
    
    private func dateSelection() {
        store.dispatch(SearchTabAction.showDatePicker)
        store.dispatch(AnalyticsAction.event(.buttonTap(.search, Constants.datePickerButtonAnalytics)))
    }
}

struct VatTaxpayerSearchTab_Previews: PreviewProvider {
    static var previews: some View {
        VatTaxpayerSearchTab()
    }
}

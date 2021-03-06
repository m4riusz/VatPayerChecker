//
//  AnalyticsEvent.swift
//  MobileApp
//
//  Created by Mariusz Sut on 05/03/2021.
//  Copyright © 2021 MSut. All rights reserved.
//

import Foundation

enum AnalyticsScreen: String {
    case search
    case about
    case datePicker
}

enum AnalyticsEvent: Equatable {
    private struct Constants {
        static let screenAppear = "screenAppear"
        static let screenDisappear = "screenDisappear"
        static let showLoader = "showLoader"
        static let hideLoader = "hideLoader"
        static let error = "error"
        static let buttonTap = "buttonTap"
        static let urlOpen = "urlOpen"
        static let successSearch = "successSearch"
        static let searchByNip = "searchByNip"
        static let searchByRegon = "searchByRegon"
        static let searchByAccount = "searchByAccount"
        
        struct Parameters {
            static let screenName = "screen"
            static let button = "button"
            static let url = "url"
            static let error = "error"
        }
    }
    
    case screenAppear(_ screen: AnalyticsScreen)
    case screenDisappear(_ screen: AnalyticsScreen)
    case showLoader(_ screen: AnalyticsScreen)
    case hideLoader(_ screen: AnalyticsScreen)
    case successSearch
    case error(_ screen: AnalyticsScreen, _ error: String)
    case buttonTap(_ screen: AnalyticsScreen, _ button: String)
    case urlOpen(_ screen: AnalyticsScreen, _ url: String)
    case searchByNip
    case searchByRegon
    case searchByAccount
    
    var name: String {
        switch self {
        case .screenAppear: return Constants.screenAppear
        case .screenDisappear: return Constants.screenDisappear
        case .showLoader: return Constants.showLoader
        case .hideLoader: return Constants.hideLoader
        case .error: return Constants.error
        case .buttonTap: return Constants.buttonTap
        case .urlOpen: return Constants.urlOpen
        case .successSearch: return Constants.successSearch
        case .searchByNip: return Constants.searchByNip
        case .searchByRegon: return Constants.searchByRegon
        case .searchByAccount: return Constants.searchByAccount
        }
    }
    
    var parameters: [String: String]? {
        typealias Params = Constants.Parameters
        switch self {
        case .screenAppear(let screen): return [Params.screenName: screen.rawValue]
        case .screenDisappear(let screen): return [Params.screenName: screen.rawValue]
        case .showLoader(let screen): return [Params.screenName: screen.rawValue]
        case .hideLoader(let screen): return [Params.screenName: screen.rawValue]
        case .error(let screen, let error): return [Params.screenName: screen.rawValue, Params.error: error]
        case .buttonTap(let screen, let button): return [Params.screenName: screen.rawValue, Params.button: button]
        case .urlOpen(let screen, let url): return [Params.screenName: screen.rawValue, Params.url: url]
        case .successSearch, .searchByNip, .searchByRegon, .searchByAccount: return nil
        }
    }
}

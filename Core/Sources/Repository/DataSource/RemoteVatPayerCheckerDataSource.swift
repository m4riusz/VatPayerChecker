//
//  RemoteVatPayerCheckerDataSource.swift
//  Core
//
//  Created by Mariusz Sut on 10/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import Combine

public final class RemoteVatPayerCheckerDataSource: VatPayerCheckerDataSourceProtocol {
    private let configuration: ConfigurationProtocol
    private let debugLogger: DebugLogger
    private let session: URLSession
    private let decoder: JSONDecoder
    
    public init(configuration: ConfigurationProtocol,
                debugLogger: DebugLogger,
                session: URLSession,
                decoder: JSONDecoder) {
        self.configuration = configuration
        self.debugLogger = debugLogger
        self.session = session
        self.decoder = decoder
    }
    
    public func save(_ search: String, date: Date, result: ObjectResult<VatTaxpayer>) -> Future<ObjectResult<VatTaxpayer>, VatError> {
        debugLogger.error("Save method should not be called on remote data source")
        fatalError()
    }
    
    public func getByNip(_ nip: String, date: Date) -> Future<ObjectResult<VatTaxpayer>, VatError> {
        Future { [unowned self] promise in
            var address = self.configuration.apiAddress
            address.appendPathComponent("/api/search/nip/\(nip)")
            address.appendQueryItem(name: "date", value: date.yyyyMMdd)
            let request = URLRequest(url: address, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
            let res = session.dataTask(with: request) { [weak self] data, response, error in
                guard let strongSelf = self else {
                    promise(.failure(.unknown))
                    return
                }
                let result: Result<ObjectResult<VatTaxpayer>, VatError> = strongSelf.handleResponse(
                    decoder: strongSelf.decoder,
                                                                                                    data: data,
                                                                                                    response: response,
                                                                                                    error: error)
                switch result {
                case .success(let object):
                    debugLogger.info(object)
                    promise(.success(object))
                case .failure(let error):
                    debugLogger.error(error)
                    promise(.failure(error))
                }
            }
            res.resume()
        }
    }
    
    public func getByAccountNumber(_ accountNumber: String, date: Date) -> Future<ObjectResult<VatTaxpayer>, VatError> {
        Future { [unowned self] promise in
            var address = self.configuration.apiAddress
            address.appendPathComponent("/api/search/bank-account/\(accountNumber)")
            address.appendQueryItem(name: "date", value: date.yyyyMMdd)
            let request = URLRequest(url: address, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
            let res = session.dataTask(with: request) { [weak self] data, response, error in
                guard let strongSelf = self else {
                    promise(.failure(.unknown))
                    return
                }
                let result: Result<ObjectResult<VatTaxpayer>, VatError> = strongSelf.handleResponse(decoder: strongSelf.decoder,
                                                                                      data: data,
                                                                                      response: response,
                                                                                      error: error)
                switch result {
                case .success(let object):
                    debugLogger.info(object)
                    promise(.success(object))
                case .failure(let error):
                    debugLogger.error(error)
                    promise(.failure(error))
                }
            }
            res.resume()
        }
    }
    
    public func getByRegon(_ regon: String, date: Date) -> Future<ObjectResult<VatTaxpayer>, VatError> {
        Future { [unowned self] promise in
            var address = self.configuration.apiAddress
            address.appendPathComponent("/api/search/regon/\(regon)")
            address.appendQueryItem(name: "date", value: date.yyyyMMdd)
            let request = URLRequest(url: address, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
            let res = session.dataTask(with: request) { [weak self] data, response, error in
                guard let strongSelf = self else {
                    promise(.failure(.unknown))
                    return
                }
                let result: Result<ObjectResult<VatTaxpayer>, VatError> = strongSelf.handleResponse(decoder: strongSelf.decoder,
                                                                                      data: data,
                                                                                      response: response,
                                                                                      error: error)
                switch result {
                case .success(let object):
                    debugLogger.info(object)
                    promise(.success(object))
                case .failure(let error):
                    debugLogger.error(error)
                    promise(.failure(error))
                }
            }
            res.resume()
        }
    }
    
    private func handleResponse<T: Codable & Equatable>(decoder: JSONDecoder,
                                                        data: Data?,
                                                        response: URLResponse?,
                                                        error: Error?) -> Result<ObjectResult<T>, VatError> {
        guard error.isNil else {
            if let nsError = error as NSError?, nsError.code == NSURLErrorNotConnectedToInternet {
                return .failure(.noInternetConnection)
            }
            return .failure(.unknown)
        }
        guard let data = data else {
            return .failure(.unknown)
        }
        if let failure = try? decoder.decode(ErrorResponse.self, from: data) {
            return .failure(failure.code)
        }
        if let object = try? decoder.decode(ResultResponse<T>.self, from: data) {
            return .success(object.result)
        }
        return .failure(.unknown)
    }
}

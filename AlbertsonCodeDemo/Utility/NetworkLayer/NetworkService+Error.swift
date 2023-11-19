//
//  NetworkService+Error.swift
//  AlbertsonCodeDemo
//
//  Created by Apple  on 17/11/23.
//

import Foundation

typealias ServerError = NetworkService.ResponseError

extension NetworkService {

    /// The network response related error has been declared here.
    enum ResponseError: Error {
        case noInternet
        case networkRespose
        case requestNotFound
        case requestValidation
        case internalServer
        case unexpected(Int)
        case wrapperFailed
        case tryCatch(Error)
        case emptyData
        case none

        /// `String` represents the error in detail.
        var message: String {
            switch self {
            case .noInternet:
                return AppConstants.noInternet
            case .networkRespose:
                return AppConstants.networkRespose
            case .requestNotFound:
                return AppConstants.requestNotFound
            case .requestValidation:
                return AppConstants.requestValidation
            case .internalServer:
                return AppConstants.internalServer
            case .unexpected(let code):
                return "\(AppConstants.unexpected) - \(code)"
            case .wrapperFailed:
                return AppConstants.wrapperFailed
            case .tryCatch(let error):
                return "\(AppConstants.tryCatch) - \(error.localizedDescription)"
            case .emptyData:
                return AppConstants.emptyData
            case .none:
                return AppConstants.none
            }
        }
    }
}

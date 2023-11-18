//
//  NetworkServiceProtocol.swift
//  AlbertsonCodeDemo
//
//  Created by Apple  on 17/11/23.
//

import Foundation

/// Define methods with model
/// which are used to call respective APIs to get data
protocol NetworkServiceProtocol {
    
    /// Get the acromine with proper request.
    /// - Returns: `Result` that has success response of `AcromineModel`  and failure has error results within it.
    func getAcromine(param: Encodable) async -> Result<[AcromineModel]?, ServerError>
}

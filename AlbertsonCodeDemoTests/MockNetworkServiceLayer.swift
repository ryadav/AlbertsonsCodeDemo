//
//  MockNetworkServiceLayer.swift
//  AlbertsonCodeDemoTests
//
//  Created by Apple  on 18/11/23.
//

import XCTest
@testable import AlbertsonCodeDemo

final class MockNetworkServiceLayer: NetworkServiceProtocol {
    var getAbbreviationCalled = false
    var successResult = true
    var expectations: XCTestExpectation?
    
    func getAbbreviation(param: Encodable) async -> Result<[AbbreviationModel]?, ServerError> {
        getAbbreviationCalled = true
        expectations?.fulfill()
        
        if successResult {
            return .success([AbbreviationModel(sf: "APP", lfs: nil)])
        }
        
        return .failure(ServerError.networkRespose)
    }
}
